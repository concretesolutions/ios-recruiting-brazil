# PhilmaXXX

---

![Image/Assets.xcassets/logo.png](PhilmaXXX/)

## Instalação

---

Basta baixar o repositório e abrir o arquivo PhilmaXXX.xcworkspace, todos os pods utilizados no projeto foram mantidos.

## Fastlane

---

A instalação do Fastlane pode ser feita através dos seguintes comandos (mais detalhes podem ser seguidos nesse [guia](https://docs.fastlane.tools/getting-started/ios/setup/)):

```
# Instalando a última versão do XCode CMD Tools
xcode-select --install

# Posteriormente usando o gem para instalar o próprio Fastlane
sudo gem install fastlane -NV
```

Nesse projeto, enquanto utiliza um terminal, você pode usar o comando custom que eu fiz:

```
fastlane devpush
```

Utilizando esse comando, será efetuado o teste completo do projeto, ter % de code-coverage dele, e também um commit para a master remote, utilizando a datahora como descrição.

