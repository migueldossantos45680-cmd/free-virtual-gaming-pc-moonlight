# Free Virtual Gaming PC — Moonlight + Sunshine

Projeto para transformar **seu próprio PC Windows 11** em um host real de jogos e aplicativos, acessível pelo Moonlight usando Sunshine. Não é uma VM hospedada nem uma tela simulada: os programas executam no hardware local do host.

> **Limite importante:** o repositório e os programas de streaming podem ser gratuitos; um PC com GPU disponível gratuitamente na nuvem, de forma persistente e adequada a jogos, não é garantido. O desempenho depende exclusivamente do hardware, da conexão e da rede elétrica/internet do seu PC. Este projeto não cria GPU, RAM, Windows ou jogos que você não tenha.

## O que está incluído

- Scripts PowerShell para instalar Sunshine, Chrome e Steam via WinGet e verificar o host.
- Atalho para preparar a instalação do Roblox a partir do site oficial.
- Instruções para instalar Resident Evil 4 Remake pela Steam, usando uma cópia legítima.
- Tutorial de Moonlight, controles, acesso remoto seguro com Tailscale e solução de problemas.

## Requisitos

- Windows 11 atualizado, conta com privilégios de administrador para instalação e um PC que permaneça ligado durante a sessão.
- GPU com codificador de vídeo compatível e drivers atualizados para streaming acelerado. O script de diagnóstico informa o hardware detectado; ele não promete compatibilidade ou desempenho.
- Rede cabeada é recomendada para o host. Para 4K/120 FPS são necessários hardware, codificador, tela/driver virtual quando aplicável e rede capazes de sustentar esse modo.
- Espaço em disco para Windows, aplicativos e jogos. Resident Evil 4 Remake é um jogo comercial; compre-o e instale-o pela Steam.
- Moonlight instalado no celular, tablet ou computador cliente.

## Instalação rápida

1. Baixe ou clone este repositório no PC Windows 11 que será o host.
2. Abra **PowerShell como Administrador** na pasta do projeto.
3. Execute:

   ```powershell
   Set-ExecutionPolicy -Scope Process Bypass
   .\scripts\Install-Host.ps1
   ```

4. Para também instalar Tailscale via WinGet, use ` .\scripts\Install-Host.ps1 -InstallTailscale` (sem o espaço inicial). Tailscale requer login e configuração próprios.
5. Instale e abra Sunshine, se ainda não estiver em execução, e abra a interface local:

   ```powershell
   .\scripts\Start-Sunshine.ps1
   ```

   A interface padrão é `https://localhost:47990`. Na primeira visita, configure suas credenciais de administrador do Sunshine. O aviso de certificado local pode aparecer por ser HTTPS local com certificado autoassinado; não ignore avisos em outros endereços.
6. Execute o diagnóstico:

   ```powershell
   .\scripts\Verify-Host.ps1
   ```

7. No Sunshine, verifique a captura de desktop, áudio e dispositivos/controladores. Mantenha Sunshine e Moonlight atualizados pelas fontes oficiais.

Os scripts não baixam jogos, não contornam DRM e não alteram configurações do roteador. WinGet obtém os pacotes do repositório de pacotes configurado no Windows; revise os prompts e fontes apresentados por ele.

## Instalar os programas e jogos

### Chrome e Steam

`Install-Host.ps1` instala Google Chrome e Steam pelo WinGet. Se o comando `winget` não existir, atualize/instale o **App Installer** pela Microsoft Store e tente novamente.

### Roblox

Execute `scripts/Prepare-Roblox.ps1`. Ele abre o site oficial do Roblox para você entrar na sua conta e instalar o player pelo fluxo oficial. A instalação e o início do jogo podem depender das políticas e requisitos atuais do Roblox.

### Resident Evil 4 Remake

Instale e inicie pela Steam usando a conta que possui o jogo. O script não fornece o jogo, licença, chave ou arquivos de instalação. Confira os requisitos oficiais e o espaço livre antes de instalar. Não use cópias não autorizadas.

## Conectar pelo Moonlight na mesma rede

1. Abra Sunshine no host e deixe-o em execução.
2. Instale Moonlight no dispositivo cliente.
3. Na mesma rede local, adicione o endereço IP local do host no Moonlight. O endereço pode ser consultado com `ipconfig` no host.
4. Selecione o host no Moonlight e inicie o pareamento. Digite o PIN exibido pelo Moonlight na interface do Sunshine.
5. Inicie **Desktop** para acessar a área de trabalho; adicione aplicativos na configuração do Sunshine se quiser atalhos específicos.
6. Selecione resolução/FPS no Moonlight. As opções efetivas dependem do cliente, host, codificador, monitor/driver e rede.

## Acessar pelo celular pela internet (alternativa segura)

A opção recomendada é uma VPN de malha como Tailscale, sem abrir portas de streaming publicamente:

1. Instale Tailscale no host (`Install-Host.ps1 -InstallTailscale`) e no celular, usando a fonte oficial.
2. Entre na mesma rede Tailscale nos dois dispositivos e confirme que ambos aparecem conectados.
3. No Moonlight do celular, adicione o IP Tailscale do host (normalmente na faixa `100.x.x.x`). Faça o pareamento com o PIN na interface Sunshine e inicie Desktop.
4. Verifique as permissões e o firewall do Windows se a conexão falhar. Mantenha acesso à interface de administração Sunshine restrito à sua rede privada.

A disponibilidade de conexão direta ou relay, latência e qualidade dependem dos provedores de internet e da rede. Não exponha a interface web do Sunshine à internet pública. Não encaminhe portas do roteador indiscriminadamente nem desative o firewall. Tailscale tem plano pessoal gratuito sujeito aos termos e limites vigentes; não é hospedagem de PC e não fornece GPU.

## Controles, áudio e vídeo

- Controles conectados por Bluetooth ao celular podem ser encaminhados pelo Moonlight, conforme o sistema operacional e o suporte do cliente. Faça o pareamento Bluetooth no dispositivo que efetivamente usa o controle.
- Controles USB/Bluetooth conectados diretamente ao host também podem ser usados localmente. A emulação/encaminhamento de gamepad depende do suporte do Moonlight, Sunshine e drivers necessários no Windows.
- Áudio é capturado da saída padrão do Windows. Escolha um dispositivo de saída funcional antes de conectar e confira o volume/mixer.
- Use drivers oficiais atualizados da GPU. Resolução, 30/60/120 FPS, HDR e 4K são metas condicionais, não garantias. Se houver tela preta ou resolução limitada, atualize drivers e consulte a documentação oficial do Sunshine para configuração de display virtual.

## Acesso, segurança e privacidade

- Use senha exclusiva e forte no painel Sunshine. Nunca compartilhe PINs de pareamento, senhas ou acesso à conta Tailscale.
- Prefira Tailscale ou VPN confiável a encaminhamento de portas no roteador. Use o firewall do Windows e restrinja o acesso às pessoas/dispositivos autorizados.
- O host precisa permanecer ligado e conectado à internet; o modo de suspensão interrompe o streaming. Ajuste energia conscientemente, considerando consumo e segurança.
- Não use este projeto em computador de terceiros sem autorização. Não há servidor central, interface web pública do projeto ou armazenamento remoto de credenciais.

## Limitações de custo

- Sunshine e Moonlight são gratuitos; Chrome, Steam e Roblox são distribuídos por seus respectivos fornecedores e sujeitos aos termos deles.
- Windows 11, computador, GPU, energia, internet e jogos podem ter custos. RE4 Remake exige uma licença legítima.
- Provedores cloud gratuitos geralmente não prometem GPU de jogos persistente; instâncias gratuitas podem suspender, limitar recursos ou não oferecer codificação de vídeo. Para evitar custos inesperados, este projeto **não** provisiona VM ou serviço de cloud.
- Uma máquina Linux/VM sem GPU compatível não equivale a um PC Windows com aceleração para jogos. A alternativa sem custo de hospedagem é usar o PC que você já possui, aceitando seu limite de desempenho.

## Estrutura

```text
scripts/
  Install-Host.ps1       Instala Sunshine, Chrome e Steam; Tailscale opcional
  Prepare-Roblox.ps1     Abre o fluxo oficial para instalar Roblox
  Start-Sunshine.ps1     Inicia/abre Sunshine e seu painel local
  Verify-Host.ps1        Relatório de sistema, GPU, memória, disco e apps
```

## Desinstalação

Desinstale os aplicativos em **Configurações > Aplicativos > Aplicativos instalados** ou pelo WinGet, conferindo o ID antes. Remova a associação dos dispositivos no Sunshine e encerre/remova o host da sua rede Tailscale se não for mais usá-los. Os scripts não removem jogos, dados do usuário nem drivers.

## Referências oficiais

- Sunshine: https://docs.lizardbyte.dev/projects/sunshine/latest/
- Moonlight: https://moonlight-stream.org/
- Tailscale: https://tailscale.com/kb/
- Roblox: https://www.roblox.com/
- Steam: https://store.steampowered.com/

## Licença

Consulte `LICENSE`. A licença deste repositório não altera as licenças/termos de Sunshine, Moonlight, Windows, aplicativos ou jogos.
