# The script of the game goes in this file.

# Declare characters used by this game. The color argument colorizes the
# name of the character.

define t = Character("Tanya", color="#2b927b", who_outline=[(0, 0, 0, 255), 2])

image tanya_sprite = im.Scale("tanya_serious.png", 600, 1000)


# The game starts here.

label start:

    # Show a background. This uses a placeholder by default, but you can
    # add a file (named either "bg room.png" or "bg room.jpg") to show it.

    scene lg_intro_1 with fade
    pause 2.5

    scene lg_intro_2 with fade
    pause 2.5

    scene lg_intro_3 with fade
    pause 2.5
     

    # Show a character sprite
    show tanya_sprite at center

    # Display lines of dialogue
    t "It's good to see you again, General."

    t "I wish we had met under better circumstances, but these are dire times."

    show tanya_sprite at right with move

    t "As you're well aware, Wieslania has declared war against our allied neighbour, Altraverdo."

    t "They have taken considerable ground across the region, and if this continues, it won't be long before Caerulum herself becomes the battlefield."

    t "Our supply lines need your help to be maintained, sir. The men at the front are depending on them."

    t "Caerulum is a mother to us all. Our soldiers will fight to the death to defend her and her allies, but they won't survive long without reinforcements and resources."

    t "As your secretary, I will do my utmost to aid you in your endeavour, but this war ultimately rests on your shoulders."

    show tanya_sprite at center with move

    t "And General .. sir .."

    t ".. I am sorry that you have to go through the pain of war again .. "

    t ".. especially since you've done so much for your country .."

    t "But Caerulum needs you again, the men need you .. We all do."

    t "Good luck, General."

    # This ends the game and quits Ren'Py properly
    $ renpy.quit()  # Exit Ren'Py and return control to Godot
