/* ==================== (i) VECTOR: REALLOC AT EACH UPDATE */

struct Stack {
    int top;                      /* pointer to the top of the stack */
    int* array;                   /* stack elements */
  };
  
  struct Stack* createStack() 
  { 
      struct Stack* stack = (struct Stack*)malloc(sizeof(struct Stack));
      stack->top = -1;
      stack->array = (int*)malloc(sizeof(int));
      return stack;
  }
  
  int isEmpty(struct Stack* stack){
      if(stack->top == -1)
          return 1;
      else
          return 0;
  }
  
  void push(struct Stack* stack, int item){
      stack->top += 1;
      stack->array = (int*)realloc(stack->array, (stack->top + 1) * sizeof(int));
      stack->array[stack->top] = item;
  }
  
  int pop(struct Stack* stack){
      if(isEmpty(stack))
          exit(1);
      int item = stack->array[stack->top];
      stack->top -= 1;
      stack->array = (int*)realloc(stack->array, sizeof(int) * (stack->top + 1));
      return item;
  }
  
  
  /* ==================== (ii) VECTOR: REALLOC AT POWERS OF 2 */
  
  struct StackFast {
    int top;                      /* pointer to the top of the stack */
    int* array;                   /* stack elements */
  };
  
  static int length = 32;
  struct StackFast* createStackFast() 
  { 
      struct StackFast* stack = (struct StackFast*)malloc(sizeof(struct StackFast));
      stack->top = -1;
      stack->array = (int*)malloc(sizeof(int) * length);
      return stack;
  }
  
  int isEmptyFast(struct StackFast* stack){
      if(stack->top == -1)
          return 1;
      else 
          return 0;
  }
  
  void pushFast(struct StackFast* stack, int item){
      stack->top += 1;
      
      if(stack->top % length == 0 && stack->top != 0)
      {
          length *= 2;
          stack->array = (int*)realloc(stack->array, sizeof(int) * length);
      }
      
      stack->array[stack->top] = item;
  }
  
  int popFast(struct StackFast* stack){
      if(isEmptyFast(stack))
          exit(1);
      
      int item = stack->array[stack->top];
      stack->top -= 1;
      if(stack->top <= length/2 && length > 32)
      {
          length /= 2;
          stack->array = (int*)realloc(stack->array, sizeof(int) * length);
      }
      
      return item;
  }
    