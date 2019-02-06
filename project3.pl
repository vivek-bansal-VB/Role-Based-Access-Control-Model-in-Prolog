:- import member/2 from basics.
:- import append/3 from basics.
:- import sort/3 from basics.
:- import between/3 from basics.
:- import append/2 from basics.
:- import length/2 from basics.

% to get predicates of all edges
edge(X,Y) :- 
    rh(X,Y).

% to check if there is a path exists from A to B
path(A,B) :-
  walk(A,B,[]).

walk(A,B,V) :-       
  edge(A,X) ,        
  not(member(X,V)), 
  (                 
    B = X;                 
    walk(X,B,[A|V])  
  ).              

% base case for my_role_hierarchy
my_role_hierarchy(X,Y,S):-
  rh(X,Y).

% base case for my_authorized_role
my_authorized_role(X,Y,S):-
  ur(X,Y).

% to get role hierarchy for rule X
my_role_hierarchy(X,Y,S):-
  rh(X,Z),
  not(member(Z,S)),
  my_role_hierarchy(Z,Y,[Z|S]).

% to get authorization role for user X
my_authorized_role(X,Y,S):-
  ur(X,Z),
  not(member(Z,S)),
  my_role_hierarchy(Z,Y,[Z|S]).

% to get both direct roles and descendant roles for User
authorized_roles(User,List_Roles) :-
    findall(Y, my_authorized_role(User,Y,[]), S),
    sort(S,List_Roles).

% to get permissions for the User
authorized_permissions(User,List_Permissions) :-
    authorized_roles(User,List_Roles),
    setof(P, X^Y^(member(X, List_Roles), rp(X,Y), P is Y), List_Permissions1),
    List_Permissions = List_Permissions1.
   % sort(List_Permissions1, List_Permissions).

% to get permisions to compute min Roles.
min_permissions(User,List_Permissions) :-
    authorized_roles(User,List_Roles),
    setof(P, X^Y^(member(X, List_Roles), rp(X,Y), P is Y), List_Permissions1),
    sort(List_Permissions1, List_Permissions).

getpermissions(1, L):-
    min_permissions(1, L),!.

getpermissions(X, L):-
      min_permissions(X, L);
      N is X-1,
      getpermissions(N, L).
      
% to get minroles required to cover all users
minRoles(S):-
    users(X),
    setof(L, getpermissions(X,L), LL),
    length(LL, S).