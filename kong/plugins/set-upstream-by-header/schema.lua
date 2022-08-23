local typedefs = require "kong.db.schema.typedefs"

return {
  name = "set-upstream-by-header",
  fields = {
    {consumer = typedefs.no_consumer},
    {
      config = {
        type = "record",
        fields = {
          {
            header = {
              type = "string",
              required = true
            }
          },
          {
            header_value_and_upstream_map = {
              type = "map",
              keys = { type = "string", },
              values = { type = "string", },
              required = true
            }
          },
          {
            header_matching = {
              type = "string",
              one_of = { "exact", "regex" },
              required = true
            }
          },
          {
            default_upstream = {
              type = "string",
              required = true
            }
          },
        },
      }
    }
  },
  entity_checks = {
  }
}