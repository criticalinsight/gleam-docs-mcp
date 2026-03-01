import gleam/http/request
import gleam/httpc
import gleam/json
import gleam/dynamic.{type Dynamic}
import gleam/result
import gleam/list
import gleam/option.{type Option, None, Some}
import mcp_toolkit_gleam/core/mcp_ffi

pub type HexPackage {
  HexPackage(
    name: String,
    version: String,
    description: String,
    docs_url: Option(String),
    html_url: String,
    repository_url: Option(String),
  )
}

pub fn search_packages(query: String) -> Result(List(HexPackage), String) {
  let url = "https://hex.pm/api/packages?search=" <> query
  use dyn <- result.try(fetch_json(url))
  Ok(decode_package_list(dyn))
}

pub fn get_package_releases(package_name: String) -> Result(Dynamic, String) {
  let url = "https://hex.pm/api/packages/" <> package_name
  fetch_json(url)
}

fn fetch_json(url: String) -> Result(Dynamic, String) {
  use req <- result.try(
    request.to(url) 
    |> result.map_error(fn(_) { "Invalid Hex API URL" })
  )
  let req = request.set_header(req, "user-agent", "native-docs-mcp/0.1.0")

  use resp <- result.try(
    httpc.send(req)
    |> result.map_error(fn(_) { "Failed to connect to Hex.pm" })
  )

  case resp.status {
    200 -> {
      json.parse(resp.body, mcp_ffi.identity_decoder())
      |> result.map_error(fn(_) { "Failed to parse Hex.pm response" })
    }
    _ -> Error("Hex.pm API returned status " <> int_to_string(resp.status))
  }
}

fn decode_package_list(dyn: Dynamic) -> List(HexPackage) {
  let items: List(Dynamic) = mcp_ffi.unsafe_coerce(dyn)
  items |> list.map(decode_package)
}

fn decode_package(item: Dynamic) -> HexPackage {
  let name = get_string(item, "name", "unknown")
  let meta = get_dynamic(item, "meta")
  let description = get_string(meta, "description", "")
  let html_url = get_string(item, "html_url", "")
  
  HexPackage(
    name: name,
    version: get_string(item, "latest_version", "0.0.0"),
    description: description,
    docs_url: Some("https://hexdocs.pm/" <> name),
    html_url: html_url,
    repository_url: None,
  )
}

fn get_string(dyn: Dynamic, key: String, default: String) -> String {
  case mcp_ffi.erl_get_map_value(dyn, key) {
    Ok(v) -> mcp_ffi.unsafe_coerce(v)
    Error(_) -> default
  }
}

fn get_dynamic(dyn: Dynamic, key: String) -> Dynamic {
  case mcp_ffi.erl_get_map_value(dyn, key) {
    Ok(v) -> v
    Error(_) -> dyn
  }
}

@external(erlang, "erlang", "integer_to_binary")
fn int_to_string(i: Int) -> String
