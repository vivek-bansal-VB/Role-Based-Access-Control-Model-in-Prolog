:- consult(project3).

% input format
users(3).
roles(5).
perms(5).
ur(1,1).
ur(1,2).
ur(2,3).
ur(2,4).
ur(3,5).
rp(1,1).
rp(1,2).
rp(2,3).
rp(2,4).
rp(5,3).
rp(5,4).
rh(3,4).
rh(4,5).
rh(4,3).
rh(5,4).

% output format
% authorized_roles(2,List_roles).
% List_roles = [3,4,5]

% authorized_permissions(1, List_Permissions).
% List_Permissions = [1,2,3,4]

% min_Roles(S).
% S = 2