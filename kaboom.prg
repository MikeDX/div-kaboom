/*
 KABOOM! (atari2600) remake



*/

program kaboom;

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
    speed=1;


begin

    graph=2;
    x=160;
    y=50;

    loop
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
        x=mouse.x;
        frame;
    end


end


