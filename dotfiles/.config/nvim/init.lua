-- ~/.config/nvim/init.lua

-- Número de línea y número relativo
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 1

-- Configuración del mouse
vim.o.mouse = "r"

-- Configuración del portapapeles
vim.o.clipboard = "unnamed"

-- Mostrar comandos y reglas
vim.o.showcmd = true
vim.o.ruler = true

-- Configuración de la codificación
vim.o.encoding = "utf-8"

-- Resaltado de la coincidencia de paréntesis y corchetes
vim.o.showmatch = true

-- Ancho de la tabulación
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- Indentación automática
vim.o.autoindent = true
vim.o.smartindent = true

-- Estado de la barra inferior
vim.o.laststatus = 2

-- Configuración de fondo oscuro
vim.o.background = "dark"

-- Habilitar colores en terminal
vim.o.termguicolors = true

-- No usar expansión de tabuladores (para copiar y pegar)
vim.o.expandtab = false

-- No expandir la tabulación
vim.o.shiftwidth = 2
vim.o.softtabstop = 2


require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"
