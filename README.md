# cine_topia

A new Flutter project.

## Getting Started

# 🎬 Cinetopia

Um aplicativo Flutter moderno para descobrir e explorar filmes usando a API do The Movie Database (TMDB).

## ✨ Características

- 🎯 **Design Patterns**: Implementação de padrões de design para código limpo e reutilizável
- 🎨 **Interface Elegante**: Design moderno com tema roxo e gradientes
- 🔍 **Busca de Filmes**: Pesquise filmes por nome ou navegue pelos populares
- 📱 **Responsivo**: Interface adaptável para diferentes tamanhos de tela
- 🌟 **Navegação Intuitiva**: BottomNavigationBar para fácil navegação

## 🚀 Tecnologias

- **Flutter** - Framework de desenvolvimento mobile
- **Dart** - Linguagem de programação
- **HTTP** - Requisições para API
- **TMDB API** - Base de dados de filmes

## 📁 Estrutura do Projeto

```
lib/
├── app/
│   ├── models/
│   │   └── movie.dart
│   ├── providers/
│   │   └── movies_provider.dart
│   ├── services/
│   │   └── search_movies_service.dart
│   └── ui/
│       ├── components/
│       │   ├── buttons.dart
│       │   └── movie_card.dart
│       └── screens/
│           ├── dashboard.dart
│           ├── home_page.dart
│           ├── releases.dart
│           └── search_movies.dart
├── app.dart
└── main.dart
```

## 🛠️ Configuração

### Pré-requisitos

- Flutter SDK (versão 3.0+)
- Dart SDK
- Chave da API do TMDB

### Passos para rodar

1. **Clone o repositório**
```bash
git clone <URL_DO_SEU_REPOSITORIO>
cd cine_topia
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Configure a API do TMDB**
   - Acesse [TMDB](https://www.themoviedb.org/)
   - Crie uma conta e obtenha sua chave da API
   - Substitua `'SUA_CHAVE_AQUI'` no arquivo `lib/app/services/search_movies_service.dart`

4. **Execute o app**
```bash
flutter run
```

## 🎨 Screenshots

[Adicione screenshots do seu app aqui]

## 🔧 Funcionalidades Implementadas

- [x] Tela inicial com gradiente
- [x] Navegação entre telas
- [x] Integração com TMDB API
- [x] Componentes reutilizáveis
- [x] Design responsivo
- [ ] Cache de imagens
- [ ] Favoritos
- [ ] Detalhes do filme

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

Desenvolvido com ❤️ usando Flutter

---

⭐ Se este projeto te ajudou, deixe uma estrela!
