git config --global safe.directory '*'
git config --global core.editor "code --wait"
git config --global pager.branch false

echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" >> ~/.bashrc
echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.zsh_history" >> ~/.zshrc
sudo chown -R vscode /commandhistory

echo "DONE!"
