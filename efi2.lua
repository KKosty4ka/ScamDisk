local cp, cl = component.proxy, component.list
local gpu = cp(cl("gpu")())
local eeprom = cp(cl("eeprom")())

local resX, resY = 80, 25
gpu.setResolution(resX, resY)

local function input(x, y)
    local output = ""
    local running = true
    
    while running do
        local e, _, c, _ = computer.pullSignal()
        if e == "key_down" then
            if c == 13 then
                running = false
            else
                if (string.char(c):find("%d") ) then 
                	output = output .. string.char(c)
                end
            end
            
            gpu.set(x, y, ">" .. output)
        elseif e == "clipboard" then
        	output = output .. c
        	gpu.set(x, y, ">" .. output)
        end
    end
    
    return output
end

local key = math.random(0, 100)

gpu.setBackground(0x000000)
gpu.setForeground(0xFFFFFF)
gpu.fill(1, 1, resX, resY, " ")
gpu.set(1, 1, "To unlock your computer, go to")
gpu.set(1, 2, "kkosty4ka.pythonanywhere.com?id=" .. tostring( key ) )
gpu.set(1, 3, "And enter key here (srry for shitty coded input):")

if ( tonumber( input(1, 4) ) == (key * key * (key + key) + key) ) then
	eeprom.set([[local a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r="MineOS EFI","Change label","key_down","filesystem",0x2D2D2D,0xE1E1E1,0x878787,0x878787,0xE1E1E1,component.proxy,component.list,computer.pullSignal,computer.uptime,table.insert,math.max,math.min,math.huge,math.floor;local s,t,u=j(k("eeprom")()),j(k("gpu")()),k("internet")()t.bind(k("screen")(),true)local v,w,x,y,z,A,B,C,D=computer.shutdown,t.set,t.setBackground,t.setForeground,t.fill,s.setData,s.getData,t.getResolution()local E,F,G,H={{"/OS.lua",function()end},{"/init.lua",function()computer.getBootAddress,computer.setBootAddress=B,A end}},function(I,J,K,L,M)x(M)z(I,J,K,L," ")end,function(J,N,O)local I=r(C/2-#O/2)y(N)w(I,J,O)end,function(O,P,Q)return{s=O,c=P,b=Q}end;local function R(J,S)J=r(D/2-J/2)F(1,1,C,D,f)G(J,e,S)return J+2 end;local function T(S,U,V)local W={}for X in U:gmatch("[^\r\n]+")do W[#W+1]=X:gsub("\t","  ")end;local J=R(#W,S)for Y=1,#W do G(J,g,W[Y])J=J+1 end;if V then repeat V=l()until V==c or V=="touch"end end;local function Z(...)local _,a0=load(...)if _ then _,a0=xpcall(_,debug.traceback)if _ then return end end;T(a,a0,1)end;local a1,a2,a3,a4=function(a5)for Y=1,#E do if a5.exists(E[Y][1])then T(a,"Booting from "..(a5.getLabel()or a5.address))if B()~=a5.address then A(a5.address)end;E[Y][2]()local a6,a7,a8,a9,a0=a5.open(E[Y][1],"rb"),""repeat a8=a5.read(a6,q)a7=a7 ..(a8 or"")until not a8;a5.close(a6)Z(a7,"="..E[Y][1])return 1 end end end,function(aa)return H("Back",aa,1)end,function(S,ab)local ac,ad=1,0;for Y=1,#ab do ad=math.max(ad,#ab[Y].s)end;while 1 do local J,I,ae=R(#ab+2,S)for Y=1,#ab do I=r(C/2-#ab[Y].s/2)if Y==ac then F(r(C/2-ad/2)-2,J,ad+4,1,h)y(i)w(I,J,ab[Y].s)x(f)else y(g)w(I,J,ab[Y].s)end;J=J+1 end;ae={l()}if ae[1]==c then if ae[4]==200 and ac>1 then ac=ac-1 elseif ae[4]==208 and ac<#ab then ac=ac+1 elseif ae[4]==28 then if ab[ac].c then ab[ac].c()end;if ab[ac].b then return end end end end end,function(J,af)local O,ag,ah,ae,ai="",true;while 1 do ah=af..O;z(1,J,C,1," ")y(g)w(r(C/2-#ah/2),J,ah..(ag and"█"or""))ae={l(0.5)}if ae[1]==c then if ae[4]==28 then return O elseif ae[4]==14 then O=O:sub(1,-2)else ai=unicode.char(ae[3])if ai:match("^[%w%d%p%s]+")then O=O..ai end end;ag=true elseif ae[1]=="clipboard"then O=O..ae[3]elseif not ae[1]then ag=not ag end end end;T(a,"Hold Alt to show boot options")local aj,ae=m()+1;while m()<aj do ae={l(aj-m())}if ae[1]==c and ae[4]==56 then local ak={H("Disk management",function()local al,am,an=function(O,ao)if#O<ao then O=O..string.rep(" ",ao-#O)else O=O:sub(1,ao)end;return O.."  "end,{a2()}local function ap()for Y=2,#am do table.remove(am,1)end;for aq in k(d)do local a5=j(aq)local ar,as,an=a5.getLabel()or"Unnamed",a5.isReadOnly(),{H("Set as bootable",function()A(aq)ap()end,1)}if not as then n(an,H(b,function()a5.setLabel(a4(R(2,b),"Enter new name: "))ap()end,1))n(an,H("Format",function()T(a,"Formatting filesystem "..aq)for at,au in ipairs(a5.list("/"))do a5.remove(au)end;ap()end,1))end;n(an,a2())n(am,1,H((aq==B()and"> "or"  ")..al(ar,12)..al(a5.spaceTotal()>1048576 and"HDD"or a5.spaceTotal()>65536 and"FDD"or"SYS",3)..al(as and"R"or"R/W",3)..al(string.format("%.1f",a5.spaceUsed()/a5.spaceTotal()*100).."%",6)..aq:sub(1,7).."…",function()a3(ar.." ("..aq..")",an)end))end end;ap()a3("Select filesystem",am)end),H("Shutdown",function()v()end),a2()}if u then n(ak,2,H("Internet recovery",function()local a6,a7,_,a0=j(u).request("https://raw.githubusercontent.com/IgorTimofeev/MineOS/master/Installer/Main.lua"),""if a6 then T(a,"Downloading recovery script")while 1 do _,a0=a6.read(q)if _ then a7=a7 .._ else a6.close()if a0 then T(a,a0,1)else Z(a7,"=string")end;break end end else T(a,"invalid URL-address",1)end end))end;a3(a,ak)end end;local a5=j(B())if not(a5 and a1(a5))then for aq in k(d)do a5=j(aq)if a1(a5)then break else a5=nil end end;if not a5 then T(a,"No bootable mediums found",1)end end;v()]])
	computer.shutdown(true)
else
	error("Wrong key!", 0)
end
