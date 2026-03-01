import gleam/list
import gleam/option.{None, Some}
import gleam/string
import mcp_toolkit_gleam/core/protocol as mcp
import tools/hex_client

pub fn popular_packages_handler(
  _req: mcp.ReadResourceRequest,
) -> Result(mcp.ReadResourceResult, String) {
  case hex_client.search_packages("") {
    Ok(packages) -> {
      let text =
        packages
        |> list.map(fn(p: hex_client.HexPackage) {
          p.name <> ": " <> p.description
        })
        |> string.join("\n")

      Ok(
        mcp.ReadResourceResult(meta: None, contents: [
          mcp.TextResource(mcp.TextResourceContents(
            uri: "gleam://packages",
            mime_type: Some("text/plain"),
            text: "Popular Gleam Packages:\n\n" <> text,
          )),
        ]),
      )
    }
    Error(err) -> Error("Failed to fetch popular packages: " <> err)
  }
}
