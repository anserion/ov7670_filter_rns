# ov7670_filter_rns
Аппартная реализация системы видеофильтрации с вычислениями в СОК

Распространяется проект на условиях лицензии Апач 2.0
------------------------------------------------------------------
--Copyright 2017 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

Для создания и отладки использовался ISE 14.7
FPGA board - ALINX AX309, LCD display - ALINX AN430.

В загруженном проекте отсутствуют IP-ядра:
1) clocking_core - выходы с PLL на 100 Мгц, 50 Мгц, 25 Мгц, 10 Мгц, 12.5 Мгц и 4 Мгц
2) vram_128x32_8bit - двухпортовое озу размером 4 КБайта для хранения текстовой страницы LCD и VGA контроллеров (128 знакомест по горизонтали, 32 символа по вертикали)
3) vram_scanline - двухпортовое озу размером 2Кбайта (1024 пикселя x 16 бит цветности)
Создаются эти ядра в Core Generator.
Автор реализации проекта: Ионисян Андрей Сергеевич (Россия, г. Ставрополь).
