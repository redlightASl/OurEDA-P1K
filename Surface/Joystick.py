import pygame


def my_map(x, in_min, in_max, out_min, out_max):
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

def get_value():

    pygame.init()
    clock = pygame.time.Clock()
    pygame.joystick.init()
    done = False
    value_list = [0]*16 
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                done=True

        joystick_count = pygame.joystick.get_count()

        # For each joystick:
        for i in range(joystick_count):
            joystick = pygame.joystick.Joystick(i)
            joystick.init()

            axes = joystick.get_numaxes()

            for i in range( axes ):
                axis = joystick.get_axis( i )
                value_list[i] = axis
                #clock.tick(60)

            buttons = joystick.get_numbuttons()

            for i in range( buttons ):
                button = joystick.get_button( i )
                value_list[i+5] = button

            clock.tick(20)
            # print(value_list)
            yield value_list
