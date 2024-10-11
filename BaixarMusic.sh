#!/bin/bash

MusicOrPlaylist=$1

if [[ $MusicOrPlaylist == "-m" ]]; then
    
    echo "Qual o link da música?"
    read LinkMusica
    echo "Qual o nome da música?"
    read NomeMusica

    mkdir -p ~/Music/"$NomeMusica"
    cd ~/Music/"$NomeMusica"

    # Baixa o áudio da música
    yt-dlp --extract-audio --audio-format mp3 "$LinkMusica"
    
    # Itera sobre todos os arquivos no diretório
    for arquivo in ~/Music/"$NomeMusica"/*; do
        if [[ -f "$arquivo" ]]; then
            # Extrai o nome do arquivo sem extensão .mp3
            filtro1=$(basename "$arquivo" .mp3)
            # Remove o conteúdo entre colchetes
            filtro2=$(echo "$filtro1" | sed 's/\[[^]]*\]//g')

            echo "Nome filtrado: $filtro2"
            # Atualiza os metadados ID3 do arquivo
            id3v2 -a "$filtro2" -t "$filtro2" "$arquivo"
            # Renomeia o arquivo para o nome da música filtrado
            mv "$arquivo" "$filtro2.mp3"
        fi
    done

elif [[ $MusicOrPlaylist == "-p" ]]; then

    echo "Qual o link da playlist?"
    read LinkPlaylist
    echo "Qual o nome da playlist?"
    read NomePlaylist

    mkdir -p ~/Music/"$NomePlaylist"
    cd ~/Music/"$NomePlaylist"

    # Baixa o áudio da playlist
    yt-dlp --extract-audio --audio-format mp3 "$LinkPlaylist"
    
    # Itera sobre todos os arquivos no diretório
    for arquivo in ~/Music/"$NomePlaylist"/*; do
        if [[ -f "$arquivo" ]]; then

            # Extrai o nome do arquivo sem extensão .mp3
            filtro1=$(basename "$arquivo" .mp3)
            # Remove o conteúdo entre colchetes
            filtro2=$(echo "$filtro1" | sed 's/\[[^]]*\]//g')

            # Atualiza os metadados ID3 do arquivo
            id3v2 -a "$filtro2" -t "$filtro2" "$arquivo"
            # Renomeia o arquivo para o nome da música fornecido pelo usuário
            mv "$arquivo" "$filtro2.mp3"
        fi
    done

else
    echo "Opção inválida. Use -m para música ou -p para playlist."
fi
mpc update
