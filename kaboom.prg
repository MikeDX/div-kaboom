/*
 KABOOM! (atari2600) remake



*/

program kaboom;

global
    lives=3;
    level=1;
    score=0;
    playing=0;
    bombs=0;
    missed=0;

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
        if(missed>0)
            missed-=4;
           // frame(500);
            if(missed<=0)
                lives--;
                level--;
                missed=0;
            end

            frame;

        end

        if(lives==0)

            repeat
                frame;
            until(mouse.left);

            score=0;
            bombs=0;
            lives=3;
            level=1;
            playing=0;
            x=get_id(type prisoner);
            x.x=160;

            end

        frame;
    end


end

process prisoner();

private

targetx=160;
nextbomb=0;
begin

    graph=3;
    x=160;
    y=50;

    loop

        if(playing==1 && bombs>0)
            graph=2;
            if(x==targetx)

            //    targetx=rand(30,290);

                repeat
                    targetx=rand(x-(level+20),x+(level+20));

                until (targetx>30 && targetx<290)


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
                nextbomb=timer[0]+40-level;
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
                frame(1000);
                playing=0;
            end
        end

        if(missed>0)
            graph=4;
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
        graph=0;
        if(lives>pid)

        if(playing==0 && pid==0)
            if(mouse.left)
                playing=1;
                bombs=(level+1)*5;
                level++;
                missed=0;
            end
        end
        graph=5+explode;

        if(missed==0)
            x=mouse.x;


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
        end
        end

        frame;
    end


end


process bomb(x)

private


begin
    graph=12;

    y=father.y+16;

    while(y<200)
        if(missed==0)
            y++;
            y+=(level/10);
            graph=rand(9,12);
        else
            if(y>missed)
            //bigbro.x<220 || bigbro.graph>12)
                from graph=13 to 15;
                    frame(200);
                end
                y=220;
            end
        end

        frame;//(200-level*5);
    end

    if(missed==0)
        missed=210;
        bombs=0;
        explosion(x,y);
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
