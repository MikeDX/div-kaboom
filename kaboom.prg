/*
 KABOOM! (atari2600) remake



*/

program kaboom;

global
    lives=3;
    level=1;
    score=0;
    playing=0;

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

        if(playing==1)
            if(x==targetx)
                targetx=x+rand(-(5+level),(5+level));
            end

            if(x<targetx)
                x++;
            end

            if(x>targetx)
                x--;
            end

            if (timer[0]>nextbomb)
                bomb(x);
                nextbomb=timer[0]+50;
            end


        end


        frame;
    end

end

process player();

private

    pid=0;

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

        if(playing==0)
            if(mouse.left)
                playing=1;
            end
        end

        x=mouse.x;

        frame;
    end


end


process bomb(x)

begin

    y=father.y+8;

    while(y<220)
        y++;
        graph=rand(9,12);
        frame;
    end

end

