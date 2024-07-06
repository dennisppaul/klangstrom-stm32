# klangstrom-stm32

note, `klangstrom-stm32` currently only works for `KLST_PANDA`.

the files are generated for one board only ( i.e KLST_PANDA + KLST_CATERPILLAR to some degree ), however in the future there maybe different folders that can be specfied via KLST_STM32_LIBRARY_PATH to select different ( including custom ) boards.

```
.
├── README.md
├── KLST_PANDA
│   ├── Core
│   ├── CMakeLists.txt
│   ├── Drivers
│   ├── Middlewares
│   ├── KLST_PANDA-STM32H723ZGT-BSP.ioc
│   ├── STM32H723ZGTX_FLASH.ld
│   └── ...
├── KLST_SHEEP
│   ├── Core
│   ├── ...
└── KLST_TINY
│   ├── Core
│   ├── ...
...
```
