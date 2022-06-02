local e={}local t=require("cc.expect").expect local a=6 local o=false local
i={}local function n(s)local h=""for r=1,s do local d=math.random(48,109)if
d>=58 then d=d+7 end if d>=91 then d=d+6 end h=h..string.char(d)end return h
end function
e.new(l,u,c,m,f,w,y)t(1,l,"number")t(1,u,"number")t(1,c,"number")t(1,m,"number")t(1,f,"function")t(1,w,"table","nil")t(1,y,"boolean","nil")y=y==nil
and true or false local p,v=term.getCursorPos()if w then if o then if#w~=m then
error("Image must be same height as button",2)end end for b=1,#w do
if#w[b][1]~=#w[b][2]or#w[b][1]~=#w[b][3]then
error("tDraw line"..tostring(b).."is not equal to other lines",2)end if o then
if#w[b][1]~=c then error("Image must be same width as button",2)end end end end
local g=n(a)i[g]={x=l,y=u,w=c,h=m,fFunc=f,tDraw=w,enabled=y,}if w then for
k=1,#w do local q=w[k]term.blit(q[1],q[2],q[3])end term.setCursorPos(p,v)end
return g end function e.delete(j)t(1,j,"string","nil")if i[j]then i[j]=nil end
end function e.enable(x,z)t(1,x,"string")t(2,z,"boolean")if not i[x]then
error("Button "..x.." does not exist.",2)end i[x].enabled=z end function
e.exec(E,T,A)t(1,E,"table")t(2,T,"boolean","nil")t(3,A,"boolean","nil")T=T or
false A=A or false if E[1]=="mouse_click"or T and E[1]=="mouse_drag"or A and
E[2]=="monitor_touch"then local O,I=E[3],E[4]for N,S in pairs(i)do if S.enabled
and O>=S.x and O<=S.x+S.w-1 and I>=S.y and I<=S.y+S.h-1 then
pcall(S.fFunc,O-S.x+1,I-S.y+1)end end end end function
e.drawButton(H)t(1,H,"string")if i[H]and i[H].tDraw then local R=i[H].tDraw
local D,L,U,C=i[H].x,i[H].y,i[H].w,i[H].h if o then if#R~=C then
error("image must be same height as button",2)end end for M=1,#R do
if#R[M][1]~=#R[M][2]or#R[M][1]~=#R[M][3]then
error("image line"..tostring(M).."is not equal to other lines",2)end if o then
if#R[M][1]~=U then error("Image must be same width as button",2)end end end
local F,W=term.getCursorPos()if R then for Y=1,#R do local
P=R[Y]term.setCursorPos(D,L+Y-1)term.blit(P[1],P[2],P[3])end
term.setCursorPos(F,W)end end end function e.drawButtons()for V in pairs(i)do
e.drawButton(V)end end function
e.edit(B,G,K,Q,J,X,Z)t(1,B,"string")t(2,G,"number","nil")t(3,K,"number","nil")t(4,Q,"number","nil")t(5,J,"number","nil")t(6,X"function","nil")t(7,Z,"table","nil")if
not i[B]then error("Button "..B.." does not exist.",2)end G=G or i[B].x K=K or
i[B].y Q=Q or i[B].w J=J or i[B].h local et=X or i[B].fFunc local tt=Z or
i[B].tDraw local at=i[B].enabled
i[B]={x=G,y=K,w=Q,h=J,fFunc=et,tDraw=tt,enabled=at,}end function
e.run(ot,it)return function()while true do e.exec({os.pullEvent()},ot,it)end
end end local
nt={newButton=e.new,deleteButton=e.delete,enableButton=e.enable,executeButtons=e.exec,execute=e.exec,editButton=e.edit,}return
setmetatable(e,{__index=nt})