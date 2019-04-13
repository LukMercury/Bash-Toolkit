# Start cmus music player in a tmux session

ps -e | grep tmux || terminology -e tmux

cmusStart() 
{
    tmux new-window -ncmus 'cmus'
    tmux swap-window -t 0
}

ps -e | grep cmus | grep -v \<defunct\> || cmusStart

