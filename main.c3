module autoscroll;

import std::thread;

extern fn void mouse_event(MouseInputFlags flags, int dx, int dy, int data, void* extra_info);
extern fn short get_async_key_state(int virtual_key) @extern("GetAsyncKeyState");

const int FORWARD_MOUSE_BUTTON_VIRTUAL_KEY = 6;
const int BACK_MOUSE_BUTTON_VIRTUAL_KEY = 5;

bitstruct MouseInputFlags : int
{
	bool movement : 0;
	bool left_down : 1;
	bool left_up : 2;
	bool right_down : 3;
	bool right_up : 4;
	bool middle_down : 5;
	bool middle_up : 6;
	bool x_down : 7;
	bool x_up : 10;
	bool wheel : 11;
	bool horizontal_wheel : 12;
	bool absolute : 15;
}

fn void main()
{
	while(true)
	{
		if(get_async_key_state(FORWARD_MOUSE_BUTTON_VIRTUAL_KEY) != 0)
		{
			mouse_event({ .wheel = true }, 0, 0, 1, null);
		}
		else if(get_async_key_state(BACK_MOUSE_BUTTON_VIRTUAL_KEY) != 0)
		{
			mouse_event({ .wheel = true }, 0, 0, -1, null);
		}
		
		thread::sleep_ms(1);
	}
}