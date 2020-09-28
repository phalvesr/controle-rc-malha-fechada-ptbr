# Controle Circuito RC em malha fechada

### Lista de Tarefas ###

- [x] Decidir o modelo microcontrolador e a línguagem de progrmação do microcontrolador (PIC 16f876A e C ANSI);
- [x] Montar o hardware (Microcontrolador, Circuito RC e Display LCD);
- [x] Rodar as simulações no [**Simulink**](https://pt.wikipedia.org/wiki/Simulink) para ter uma ideia da faixa de ganhos (Kp, Ki e Kd) interessante;
- [x] Escrever o programa básico para interface com usuário;
- [x] Escrever algoritmo para a parcela proporcional;
- [x] Escrever o algoritmo para a parcela integral (Baseado no algoritmo do [**Brett Beauregard**](http://brettbeauregard.com/blog/) e na [**forma numérica**](https://pt.wikipedia.org/wiki/Integra%C3%A7%C3%A3o_num%C3%A9rica#Ordem_de_aproxima%C3%A7%C3%A3o));
- [x] Escrever o algoritmo para a parcela derivativa;
- [ ] Ajustar os ganhos;
- [ ] **Testar, testar, testar e... Ah! testar mais um pouco!**

##### **OFF (Relacionado a interface com o computador)** #####
- [ ] Conseguir configurar o drivers do módulo conversor TTL para Serial (Windows e Linux);
- [ ] Ler dados da Serial no back-end e enviar por uma rota em formato JSON;
- [ ] Receber os dados em JSON e manipular uma interface web;
