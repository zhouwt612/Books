function [x,val,k]=dampnm(fun,gfun, Hess,x0)
%功能: 用阻尼牛顿法求解无约束问题:  min f(x)
%输入: x0是初始点, fun, gfun, Hess 分别是求
%         目标函数,梯度,Hesse 阵的函数
%输出:  x, val分别是近似最优点和最优值,  k是迭代次数.
maxk=100;   %给出最大迭代次数
rho=0.55;sigma=0.4;
k=0;  epsilon=1e-5;
while(k<maxk)
    gk=feval(gfun,x0); %计算梯度
    Gk=feval(Hess,x0);  %计算Hesse阵
    dk=-Gk\gk; %解方程组Gk*dk=-gk, 计算搜索方向
    if(norm(gk)<epsilon), break; end  %检验终止准则
    m=0; mk=0;
    while(m<20)   % 用Armijo搜索求步长 
        if(feval(fun,x0+rho^m*dk)<feval(fun,x0)+sigma*rho^m*gk'*dk)
            mk=m; break;
        end
        m=m+1;
    end
    x0=x0+rho^mk*dk;
    k=k+1;
end
x=x0;
val=feval(fun,x); 
%gval=norm(gfun(x));
%%%% 目标函数 %%%%%%%%%
%function f=fun(x)
%f=100*(x(1)^2-x(2))^2+(x(1)-1)^2;
%%%% 梯度 %%%%%%%%%%%%%%%%%%%
%function g=gfun(x)
%g=[400*x(1)*(x(1)^2-x(2))+2*(x(1)-1), -200*(x(1)^2-x(2))]';
%%%% Hesse 阵 %%%%%%%%%%%%%%%%%%%
%function He=Hess(x)
%n=length(x);
%He=zeros(n,n);
%He=[1200*x(1)^2-400*x(2)+2, -400*x(1); 
 %        -400*x(1),                         200        ];
