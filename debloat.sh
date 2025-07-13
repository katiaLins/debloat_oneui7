#!/bin/bash

# Script de Debloat para Samsung OneUI 7.0


######## Check
if ! which adb 1>/dev/null 2>/dev/null; then
    echo "Erro. Instale o adb (android-tools)."
    exit 1
else
    # Start server.
    adb start-server
fi

echo "+---------------------------------------------+"
echo "Checando os dispositivos conectados..."
# Check if have devices.
output=$(adb devices | tail -n +2)
if [[ -z "$output" ]]; then
    echo "Não encontrei nenhum dispositivo. Plugue seu celular no computador."
    echo "+---------------------------------------------+"
    exit 1
fi

output=${output//device}
echo "Dispositivos ----> $output"
echo "+---------------------------------------------+"

echo


# Função para exibir o menu e obter a escolha do usuário
show_menu() {
    echo "Selecione o nível de debloat:"
    echo "1) Básico"
    echo "2) Leve"
    echo "3) Pesado"
    echo "4) Remover Galaxy AI e Google Gemini"
    read -p "Escolha uma opção: " choice
    echo ""
}

# Função para executar o debloat
debloat() {
    list_file=$1
    echo "Lendo a lista de pacotes de $list_file..."
    echo ""

    if [ ! -f "$list_file" ]; then
        echo "Arquivo de lista de pacotes não encontrado!"
        exit 1
    fi

    while IFS= read -r package || [[ -n "$package" ]]; do
        if [[ ! $package =~ ^# && -n $package ]]; then
            echo "Desinstalando $package..."
            adb shell pm uninstall -k --user 0 "$package"
        fi
    done < "$list_file"

    echo ""
    echo "Debloat concluído!"
}

# Execução principal
show_menu

case $choice in
    1)
        debloat "packages/basic_oneui7.txt"
        ;;
    2)
        debloat "packages/light_oneui7.txt"
        ;;
    3)
        debloat "packages/heavy_oneui7.txt"
        ;;
    4)
        debloat "packages/ai_gemini_oneui7.txt"
        ;;
    *)
        echo "Opção inválida!"
        ;;
esac


