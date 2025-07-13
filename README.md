# Script de Debloat para Samsung OneUI 7.0

Este projeto oferece um script de debloat para dispositivos Samsung com OneUI 7.0, permitindo remover aplicativos pré-instalados (bloatware) para melhorar o desempenho, a duração da bateria e a privacidade do seu dispositivo. O script é baseado no projeto [invinciblevenom/debloat_samsung_android](https://github.com/invinciblevenom/debloat_samsung_android), mas foi adaptado para a OneUI 7.0, considerando as mudanças e novos aplicativos presentes nesta versão.

**Atenção:** Este script foi desenvolvido para OneUI 7.0. O projeto original foi arquivado e não é recomendado para atualizações de software lançadas após janeiro de 2025. Use este script com cautela e por sua conta e risco. Recomenda-se fazer um backup completo do seu dispositivo antes de prosseguir.

## Requisitos

Para utilizar este script, você precisará:

1.  **ADB (Android Debug Bridge) instalado e configurado no seu computador.** Você pode baixar as ferramentas da plataforma SDK do Android em [developer.android.com](https://developer.android.com/studio/releases/platform-tools).
2.  **Depuração USB ativada no seu dispositivo Samsung.** Para ativar, vá em `Configurações > Sobre o telefone > Informações do software` e toque no `Número da compilação` sete vezes. Em seguida, vá em `Configurações > Opções do desenvolvedor` e ative a `Depuração USB`.
3.  **Um cabo USB** para conectar seu dispositivo ao computador.

## Como Usar

1.  **Baixe este repositório** para o seu computador. Você pode clonar o repositório ou baixar o arquivo ZIP e extraí-lo.
2.  **Navegue até a pasta `debloat`** no seu terminal ou prompt de comando.
3.  **Execute o script `debloat.sh`** (Linux/macOS) ou `debloat.bat` (Windows) no seu terminal ou prompt de comando:

    ```bash
    # Para Linux/macOS
    ./debloat.sh
    # Para Windows
    debloat.bat
    ```

4.  O script apresentará um menu com as seguintes opções de debloat:
    *   **1) Básico:** Remove apenas o bloatware mais óbvio e seguro, mantendo a maioria das funcionalidades Samsung e Google. Permite o uso de contas Samsung e recursos Galaxy AI.
    *   **2) Leve:** Remove mais aplicativos, incluindo alguns da Samsung que não são essenciais. **Não é recomendado para usuários que desejam usar a conta Samsung e recursos associados (como Galaxy AI).**
    *   **3) Pesado:** Esta é a opção mais agressiva, removendo quase todos os aplicativos que não são essenciais para o funcionamento do sistema. **Muitas funcionalidades serão desativadas.** Use com extrema cautela.
    *   **4) Remover Galaxy AI e Google Gemini:** Remove ou desativa pacotes associados às funcionalidades de inteligência artificial da Samsung (Galaxy AI) e do Google (Gemini). Note que a remoção completa pode não ser possível devido à integração profunda no sistema.

5.  **Escolha a opção desejada** e o script fará o restante, desinstalando os pacotes correspondentes.

## Revertendo Alterações

Caso você queira reinstalar os aplicativos removidos ou reverter seu telefone para a condição original, você pode usar o script `revert.sh`:

1.  **Navegue até a pasta `debloat`** no seu terminal ou prompt de comando.
2.  **Execute o script `revert.sh`** (Linux/macOS) ou `revert.bat` (Windows):

    ```bash
    # Para Linux/macOS
    ./revert.sh
    # Para Windows
    revert.bat
    ```

3.  O script apresentará as mesmas opções de nível de debloat (Básico, Leve, Pesado, Reinstalar Galaxy AI e Google Gemini). **Escolha a mesma opção que você usou para o debloat** para reinstalar os aplicativos correspondentes.

## Listas de Pacotes

As listas de pacotes para cada nível de debloat estão localizadas na pasta `packages`:

*   `basic_oneui7.txt`
*   `light_oneui7.txt`
*   `heavy_oneui7.txt`
*   `ai_gemini_oneui7.txt`

Você pode revisar e personalizar essas listas antes de executar o script, se desejar. Cada linha no arquivo representa o nome de um pacote a ser removido. Linhas que começam com `#` são comentários e são ignoradas.

## Advertências e Considerações

*   **Faça backup:** Sempre faça um backup completo do seu dispositivo antes de realizar qualquer procedimento de debloat.
*   **Funcionalidades:** A remoção de certos aplicativos pode afetar funcionalidades do sistema ou de outros aplicativos. Esteja ciente das possíveis consequências.
*   **Atualizações:** Após uma atualização de software da Samsung, alguns aplicativos podem ser reinstalados ou novas dependências podem ser introduzidas, exigindo uma nova análise e possível adaptação do script.
*   **Galaxy AI:** As funcionalidades do Galaxy AI podem ser afetadas ou desativadas dependendo do nível de debloat escolhido, especialmente nas opções Leve e Pesado.
*   **Suporte:** Este script é fornecido como está. Não há garantia de suporte contínuo ou atualizações para futuras versões da OneUI.

## Créditos

Baseado no trabalho de [invinciblevenom](https://github.com/invinciblevenom/debloat_samsung_android).

---




