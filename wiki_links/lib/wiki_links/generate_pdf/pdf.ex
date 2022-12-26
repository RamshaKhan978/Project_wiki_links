defmodule WikiLinks.GeneratePdf.Pdf do
  use GenServer
  alias WikiLinks.Wiki_link.Link
 # Client API
 def start_link(_opts) do
  GenServer.start_link(__MODULE__, [], name: __MODULE__)
end


def generate_pdf(html) do
  GenServer.call(__MODULE__, {:generate, html})

end
def handle_call({:generate,html}, _from, state) do
  filename= PdfGenerator.generate(html, page_size: "A4", shell_params: ["--dpi", "300"])
  IO.inspect(filename)
  {:reply, filename, filename}
end
end
