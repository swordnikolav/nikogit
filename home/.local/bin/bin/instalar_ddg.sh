cd /home/sword
mkdir -p mcp-ddg-manual
cd mcp-ddg-manual

# Creamos un servidor MCP minimalista de DuckDuckGo en un solo archivo
cat << 'EOF' > ddg_server.js
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { CallToolRequestSchema, ListToolsRequestSchema } from "@modelcontextprotocol/sdk/types.js";

const server = new Server({ name: "ddg-manual", version: "1.0.0" }, { capabilities: { tools: {} } });

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [{
    name: "duckduckgo_search",
    description: "Search the web using DuckDuckGo",
    inputSchema: { type: "object", properties: { query: { type: "string" } }, required: ["query"] }
  }]
}));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === "duckduckgo_search") {
    const query = encodeURIComponent(request.params.arguments.query);
    const response = await fetch(`https://api.duckduckgo.com/?q=${query}&format=json`);
    const data = await response.json();
    return { content: [{ type: "text", text: data.AbstractText || "No results found." }] };
  }
});

const transport = new StdioServerTransport();
await server.connect(transport);
EOF
