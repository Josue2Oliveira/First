% Universidade Federal de Mato Grosso
% Instituto de Engenharia
% Inteligência Artificial - 2016/2
%
% Função Octave/MATLAB que deve implementar o algoritmo A-estrela.
% A função deve receber uma matriz __M__ com estado inicial do quebra-cabeça 
% o apontador para a função heurística __h__ e devolver um nó de busca __n__
% com o estado objetivo. Para que seja possível reconstruir o caminho percorrido 
% até a solução,  cada nó produzido pelo algoritmo de busca deve conter uma 
% referência para o nó que o descobriu (i.e., nó visitado no passo anterior).
%
% Para executar o algoritmo para um estado S com heurística de hamming por exemplo pode-ser fazer:
% S = [4 1 3; 9 2 5; 7 8 6];
% node = astar(S, @hamming);
% 
% Extra: A variável __error__ deve ser utilizada para identificar jogos que não 
% possuem solução. 
%
% author: raonifst at gmail dot com

function [n, error] = astar(M, h)
 tic
  n = Node(M, 0);
  
  q = PriorityQueue();
  
  O = [1 2 3; 4 5 6; 7 8 9];
  
  q.insert(n.f+h(n.State), n);
  
  count = 1; 
  
    while (~q.isempty())
        
        m = q.extractMin();
        
        if isequal(m.State, O),
          n = m;
          break;
          end
        
       moves = legal_moves(m.State);
       
       if(isempty(m.Prev)),
         for i=1:size(moves),
              novo_estado = do_move(m.State, moves(i));
              novo_no = Node(novo_estado, m.f+1);
              novo_no.Prev = m;
              q.insert(novo_no.f+h(novo_no.State), novo_no);
          endfor
          
       else     
         for i=1:size(moves),
              novo_estado = do_move(m.State, moves(i));
              if(isequal(novo_estado,m.Prev.State)==0)
                novo_no = Node(novo_estado, m.f+1);
                novo_no.Prev = m;
                q.insert(novo_no.f+h(novo_no.State), novo_no);
                count = count + 1;
              endif
          endfor  
        
    end
  
end
toc
count
end

