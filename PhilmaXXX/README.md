# PhilmaXXX

---

![Image](PhilmaXXX/Assets.xcassets/logo.png)

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

Na raiz desse projeto, enquanto utiliza um terminal, você pode usar o comando custom que eu fiz:

```
fastlane devpush
```

Utilizando esse comando, será efetuado o teste completo do projeto, ter % de code-coverage dele, e também um commit para a master remote, utilizando a datahora como descrição.

## Construído com

* [Fastlane](https://docs.fastlane.tools/) - Framework para pipeline automatizado
* [Quick/Nimble](https://github.com/Quick) - Unit Testing
* [Kingfisher](https://github.com/onevcat/Kingfisher/) - Gerenciamento de image-set com cache-ing automático
* [Moya](https://github.com/Moya/Moya) - Camada de conexão abstrata baseada no Alamofire
* [Eureka](https://github.com/xmartlabs/Eureka) - Gerenciamento de formulários

## Autores

* **Guilherme 'Heaven' Guimarães** - *Tudo* - [celtaheaven](https://github.com/celtaheaven)

## License

Este projeto é licenciado dentro da licença MIT - Para ver detalhes vá ao arquivo [LICENSE.md](https://github.com/angular/angular.js/blob/master/LICENSE).

## Reconhecimentos

* A todos que participaram dos meus 3 anos de BEPiD
* Aos meus amigos e familia que me motivam constantemente
