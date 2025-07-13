#!/bin/bash

# Script de Reversão para Samsung OneUI 7.0

# Função para exibir o menu e obter a escolha do usuário
show_menu() {
    echo "Selecione o nível de reversão:"
    echo "1) Básico"
    echo "2) Leve"
    echo "3) Pesado"
    echo "4) Reinstalar Galaxy AI e Google Gemini"
    read -p "Escolha uma opção: " choice
    echo ""
}

# Função para executar a reversão
revert() {
    list_file=$1
    echo "Lendo a lista de pacotes de $list_file para reinstalar..."
    echo ""

    if [ ! -f "$list_file" ]; then
        echo "Arquivo de lista de pacotes não encontrado!"
        exit 1
    fi

    while IFS= read -r package || [[ -n "$package" ]]; do
        if [[ ! $package =~ ^# && -n $package ]]; then
            echo "Reinstalando $package..."
            adb shell cmd package install-existing "$package"
        fi
    done < "$list_file"

    echo ""
    echo "Reversão concluída!"
}

# Execução principal
show_menu

case $choice in
    1)
        revert "packages/basic_oneui7.txt"
        ;;
    2)
        revert "packages/light_oneui7.txt"
        ;;
    3)
        revert "packages/heavy_oneui7.txt"
        ;;
    4)
        revert "packages/ai_gemini_oneui7.txt"
        ;;
    *)
        echo "Opção inválida!"
        ;;
esac


