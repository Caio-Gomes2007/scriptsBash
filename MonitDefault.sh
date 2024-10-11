#!/bin/bash
#ele ajuda com o php em ambiente linux, não mexe porra

##Instruções basicas de uso

#executar como sudo , ./monitoramento.sh
#ele vai copiar todos os arquivos do diretorio para outro sempre que for atualizado , TODOS.




# Diretório a ser monitorado
DIR_TO_WATCH="/home/ama_goticas/Github/Tec2024" #diretorio que sera copiado e monitorado

# Diretório de destino
DEST_DIR="/opt/lampp/htdocs/Tec2024" #localização

# Função para tratar as alterações
handle_change() {
    EVENT=$1
    FILE=$2
    REL_PATH="${FILE#$DIR_TO_WATCH/}"

    case $EVENT in
    MODIFY | CREATE | MOVED_TO)
        echo "Arquivo modificado/criado/movido: $FILE"
        cp -f "$FILE" "$DEST_DIR/$REL_PATH"
        echo "Arquivo copiado para: $DEST_DIR/$REL_PATH"
        ;;
    DELETE | MOVED_FROM)
        echo "Arquivo deletado/movido: $FILE"
        rm -f "$DEST_DIR/$REL_PATH"
        echo "Arquivo deletado de: $DEST_DIR/$REL_PATH"
        ;;
    *)
        echo "Evento desconhecido: $EVENT no arquivo $FILE"
        ;;
    esac
}

# Função para sincronizar a pasta de destino com a origem
sync_directories() {
    rsync -av --delete "$DIR_TO_WATCH/" "$DEST_DIR/"
}

# Sincronizar inicialmente as pastas
sync_directories

# Usar inotifywait para monitorar o diretório
inotifywait -m -r -e modify,create,delete,move "$DIR_TO_WATCH" --format '%e %w%f' |
    while read EVENT FILE; do
        handle_change "$EVENT" "$FILE"
        # Sincronizar novamente após cada mudança
        sync_directories
    done
