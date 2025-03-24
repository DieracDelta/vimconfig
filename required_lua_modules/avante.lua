require('img-clip').setup(
  {
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
    }
  }
)
require('render-markdown').setup(
  {
    file_types = { "markdown", "Avante" },
  }
)

require('avante_lib').load()
require('avante').setup(
  {
    rag_service = {
      enabled = false,
      -- host_mount = os.getenv("HOME"),
      -- endpoint = "http://100.74.54.40:11434",
      -- llm_model = "qwq:32b",
    },
    provider = "ollama",
    behavior = {
      enable_cursor_planning_mode = true,
    },
    ollama = {
      model = "qwq:32b",
      endpoint = "http://100.74.54.40:11434",
    }

  }
)
