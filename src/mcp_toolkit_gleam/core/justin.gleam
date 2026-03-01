import gleam/string
import gleam/list

pub fn pascal_case(name: String) -> String {
  name
  |> string.split("_")
  |> list.map(capitalize)
  |> string.join("")
}

pub fn snake_case(name: String) -> String {
  // Simple approximation for now
  string.lowercase(name)
}

fn capitalize(s: String) -> String {
  case string.pop_grapheme(s) {
    Ok(#(first, rest)) -> string.uppercase(first) <> rest
    Error(_) -> ""
  }
}
