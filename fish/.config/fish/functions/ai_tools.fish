# First, set the project path as a variable at the top of the file
set -g AI_TOOLS_PATH /home/yannick/personal/anthropic/anthropic-computer-use-bash-and-files

function ai-venv --description 'Activate the AI tools virtual environment'
    if test -d $AI_TOOLS_PATH/.venv
        source $AI_TOOLS_PATH/.venv/bin/activate.fish
        echo "Activated AI tools virtual environment"
    else
        echo "Virtual environment not found in $AI_TOOLS_PATH/.venv"
    end
end

function ai --description 'Run AI tools with bash mode'
    if test (count $argv) -eq 0
        echo "Usage: ai \"your command\""
        return 1
    end

    # Join all arguments into a single quoted string
    set -l cmd (string join " " -- $argv)
    uv run $AI_TOOLS_PATH/src/anthropic_computer_use/main.py "$cmd" --mode bash
end

function aie --description 'Run AI tools with editor mode'
    if test (count $argv) -eq 0
        echo "Usage: aie \"your command\""
        return 1
    end

    # Join all arguments into a single quoted string
    set -l cmd (string join " " -- $argv)
    uv run $AI_TOOLS_PATH/src/anthropic_computer_use/main.py "$cmd" --mode editor
end
