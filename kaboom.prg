/*
 KABOOM! (atari2600) remake



*/

program kaboom;

global
    lives=3;
    level=0;
    score=0;
    playing=0;
    bombs=0;

begin

    set_fps(50,2);
    set_mode(320240);

    load_fpg("kaboom/kaboom.fpg");

    graph=1;
    x=160;
    y=120;

    prisoner();
    player();

    loop
        frame;
    end


end

process prisoner();

private

targetx=160;
nextbomb=0;
begin

    graph=2;
    x=160;
    y=50;

    loop

        if(playing==1 && bombs>0)
            if(x==targetx)

                targetx=rand(30,290);
                /*
                repeat
                    targetx=x+rand(-(5+level*2),(5+level*2));

                until (targetx>30 && targetx<290)
                */

            end

            if(x<targetx)
                x+=level;
                if(x>targetx)
                    x=targetx;
                end

            end

            if(x>targetx)
                x-=level;
                if(x<targetx)
                    x=targetx;
                end
            end

            if (timer[0]>nextbomb)
                bomb(x);
                nextbomb=timer[0]+50-level;
                bombs--;

            end

            if(x<30)
                x=30;
                targetx=16;
            end

            if(x>290)
                x=290;
                targetx=x;
            end


        end

        if(bombs==0)
            if(!get_id(type bomb))
                frame(2400);
                playing=0;
            end
        end

        frame;
    end

end

process player();

private

    pid=0;
    bombid=0;
    explode=0;
    anim=0;
begin

    graph=5;
    clone
        pid=1;
    end

    if(pid==0)
        clone
            pid=2;
        end
    end

    y=152+pid*16;

    loop
        anim++;

        if(playing==0)
            if(mouse.left)
                playing=1;
                bombs=(level+1)*5;
                level++;

            end
        end

        x=mouse.x;
        graph=5+explode;

        if(explode>0 && anim%3==1)
            explode--;
        end

        bombid=collision(type bomb);
        if(bombid)
            if(bombid.y<y+5)
                explosion(bombid.x,bombid.y);
                signal(bombid,s_kill);
                explode=3;
            end
        end
        frame;
    end


end


process bomb(x)

private


begin
    graph=12;

    y=father.y+8;

    while(y<210)

        y++;
        graph=rand(9,12);

        frame;
    end

end

process explosion(x,y);

begin

graph=12;

while(graph<15);
    frame(300);
    graph++;
end




end
