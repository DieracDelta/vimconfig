{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    # for getting github links
    nvim-github-linker

  ];
  # setup.nvim-github-linker = {
  #   mappings = false;
  #   default_remote = "origin";
  #   copy_to_clipboard = true;
  # };
  lua = ''
    require("nvim-github-linker").setup({ mappings = true, default_remote = "origin", copy_to_clipboard = false, })
    function PipeToClipboard()
      vim.api.nvim_command('redir @+') -- Redirect output to register '+'
      vim.api.nvim_exec('GithubLink', true) -- Execute GithubLink command
      vim.api.nvim_command('redir END') -- Stop redirecting output

      local output = vim.fn.getreg('+')
      local modifiedOutput = output:gsub("^\n?git@", "")

      if modifiedOutput == "" then
        print("No output from GithubLink command")
      else
        vim.fn.setreg("+", modifiedOutput)
        print("Output has been copied to the clipboard")
      end
    end
  '';
}



