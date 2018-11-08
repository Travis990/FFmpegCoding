#include <SDL.h> 

int main(int argc, char* argv[]){

    int quit = 1;
    SDL_Event event;
    SDL_Window *window = NULL;
    SDL_Renderer *render = NULL;
    SDL_Texture *texture = NULL;
    SDL_Rect rect;
    rect.w = 60;
    rect.h = 60;
    
    SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);
    SDL_Log("Hello world");

    window = SDL_CreateWindow("hello world",
                      200,400,
                      640,
                      480,
                      SDL_WINDOW_SHOWN);
    if(!window){
        SDL_Log("Failed to Create Window!");
        goto __EXIT;
    }                  

    render = SDL_CreateRenderer(window, -1 ,0);
    if(!render){
        SDL_Log("Failed to CreateRenderer!");
        goto __DWINDOW;
    }
    /*
    SDL_SetRenderDrawColor(render, 255, 0, 0, 255);

    SDL_RenderClear(render);

    SDL_RenderPresent(render);
    */

    texture = SDL_CreateTexture(render, 
                      SDL_PIXELFORMAT_RGBA8888,
                      SDL_TEXTUREACCESS_TARGET,
                      640,
                      480);
    if(!texture){
        SDL_Log("Failed to CreateRenderer!");
        //goto __RENDER;
    }
    do{
        //SDL_Event event;
        SDL_PollEvent(&event);
        switch(event.type){
            case SDL_QUIT:
                 quit = 0;
                 break;
            default:
                 SDL_Log("event type is %d", event.type);
        }

        
        rect.x = rand() % 600;
        rect.y = rand() % 450;

        SDL_SetRenderTarget(render, texture);
        SDL_SetRenderDrawColor(render, 0, 0, 0, 0);
        SDL_RenderClear(render);

        SDL_RenderDrawRect(render, &rect);
        SDL_SetRenderDrawColor(render, 255, 0, 0, 0);
        SDL_RenderFillRect(render, &rect);

        SDL_SetRenderTarget(render, NULL);
        SDL_RenderCopy(render, texture, NULL, NULL);

        SDL_RenderPresent(render);
    }while(quit);

    SDL_DestroyTexture(texture);
    //SDL_Delay(10000);
/*
__RENDER:
    SDL_DestroyRender(render);  
*/
__DWINDOW:
    SDL_DestroyWindow(window);

__EXIT:
    SDL_Quit();
    return 0;
}