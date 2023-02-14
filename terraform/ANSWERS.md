1. С помощью команды git show aefea можно узнать подробную информацию о коммите. Полный хэш aefead2207ef7e2aa5dc81a34aedf0cad4c32545.
Комментарий коммита "Update CHANGELOG.md".

2. Также командой git show 85024d3 можно узнать и тег коммита.
Коммиту соответствует  tag: v0.12.23

3. Командой git log --graph b8d720 можно увидеть визуальное количество родителей данного коммита. В данном случает это 2 коммита:
56cd7859e05c36c06b56d013b55a252d0bb7e158 и 9ea88f22fc6269854151c571162c5bcf958bee2b

4. Командой git tag -l "v0.12.2*" выводим список тегов по шаблону и видим, что нам нужны теги только v0.12.23 и v0.12.24
Теперь командой git log v0.12.24 --pretty=oneline выводим список коммитов по одной в строчке:
33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release
85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23) v0.12.23

Или аналогично вывести список коммитов можно командой git log v0.12.23...v0.12.24 --oneline


5. Командой git log -S "func providerSource" --oneline находим хэши коммитов, где использовалась данная функция. Результат:
5af1e6234a main: Honor explicit provider_installation CLI config when present
8c928e8358 main: Consult local directories as potential mirrors of providers

После командой git show 5af1e6234a просматриваем коммит и видим, что здесь была создана данная функция.

6. Используем команду git grep "globalPluginDirs" для поиска файлов, где данная функция использовалась.
А после ищем командой git log -L :globalPluginDirs:plugins.go
Коммиты:
78b12205587fe839f10d946ea3fdc06719decb05
52dbf94834cb970b510f2fba853a5b49ad9b1a46
41ab0aef7a0fe030e84018973a64135b11abcd70
66ebff90cdfaa6938f26f908c7ebad8d547fea17
8364383c359a6b738a436d1b7745ccdce178df47


7. Используя команду git log -S "synchronizedWriters" --pretty=format:"%h - %an, %ad : %s" находим коммиты, где упоминается данная функция:
bdfea50cc8 - James Bardin, Mon Nov 30 18:02:04 2020 -0500 : remove unused
fd4f7eb0b9 - James Bardin, Wed Oct 21 13:06:23 2020 -0400 : remove prefixed io
5ac311e2a9 - Martin Atkins, Wed May 3 16:25:41 2017 -0700 : main: synchronize writes to VT100-faker on Windows
Отсюда автор функции Author: Martin Atkins <mart@degeneration.co.uk>



