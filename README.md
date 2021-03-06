# Controle Circuito RC em malha fechada

### Lista de Tarefas ###

- [x] Decidir o modelo microcontrolador e a línguagem de progrmação do microcontrolador (PIC 16f876A e C ANSI);
- [x] Montar o hardware (Microcontrolador, Circuito RC e Display LCD);
- [x] Rodar as simulações no [**Simulink**](https://pt.wikipedia.org/wiki/Simulink) para ter uma ideia da faixa de ganhos (Kp, Ki e Kd) interessante;
- [x] Escrever o programa básico para interface com usuário;
- [x] Escrever algoritmo para a parcela proporcional;
- [x] Escrever o algoritmo para a parcela integral (Baseado no algoritmo do [**Brett Beauregard**](http://brettbeauregard.com/blog/) e na [**forma numérica**](https://pt.wikipedia.org/wiki/Integra%C3%A7%C3%A3o_num%C3%A9rica#Ordem_de_aproxima%C3%A7%C3%A3o));
- [x] Escrever o algoritmo para a parcela derivativa;
- [x] Implementar um filtro digital (baseado [**neste artigo**](https://zipcpu.com/dsp/2017/08/19/simple-filter.html));
- [x] Ajustar os ganhos práticos;
- [x] Adicionar um sistema de datalog (Devo subir muito em breve);
- [x] Implementar o modo de controle de número de carga;
- [x] Implementar o mode de controle de número de elétrons;
- [x] **Testar, testar, testar e... Ah! testar mais um pouco!**

##### **OFF (Relacionado a interface com o computador)** #####
- [x] ~~Conseguir configurar o drivers do módulo conversor TTL para Serial (Windows e Linux)~~ Substituido por um Arduino enviando os dados pela serial;
- [x] Ler dados da Serial no back-end e enviar por uma rota em formato JSON;
- [x] Receber os dados em JSON e manipular uma interface web;
