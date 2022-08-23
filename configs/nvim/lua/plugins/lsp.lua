---- Settings up lsp server manager's
--local status_ok, mason = pcall(require, 'mason')
--if not status_ok then
--	return
--end
--local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
--if not status_ok then
--	return
--end
--
--mason.setup()
--mason_lspconfig.setup({
--    ensure_installed = { "python-lsp-server", "rust_analyzer" }
--}
--)
--
--
---- server Settings
--
--local status_ok, lspconfig = pcall(require, 'lspconfig')
--if not status_ok then
--	return
--end
--lspconfig.pyright.setup{}


local status_ok, lsp = pcall(require, 'lsp-zero')
if not status_ok then
	return
end

lsp.preset('recommended')
lsp.setup()
