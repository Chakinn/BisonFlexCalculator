
// A C program to demonstrate linked list based implementation of queue 
#include <stdio.h> 
#include <stdlib.h> 

struct QItem {
    int key;
    int type;
};
  
// A linked list (LL) node to store a queue entry 
struct QNode { 
    struct QItem item;
    struct QNode* next; 
}; 
  
// The queue, front stores the front node of LL and rear stores the 
// last node of LL 
struct Queue { 
    struct QNode *front, *rear; 
}; 
  
// A utility function to create a new linked list node. 
struct QNode* newNode(struct QItem item) 
{ 
    struct QNode* temp = (struct QNode*)malloc(sizeof(struct QNode)); 
    temp->item = item; 
    temp->next = NULL; 
    return temp; 
} 
  
// A utility function to create an empty queue 
struct Queue* createQueue() 
{ 
    struct Queue* q = (struct Queue*)malloc(sizeof(struct Queue)); 
    q->front = q->rear = NULL; 
    return q; 
} 

int isEmpty(struct Queue* q) {
    return (q->front == NULL);
}
  
// The function to add a key k to q 
void enQueue(struct Queue* q, struct QItem item) 
{ 
    // Create a new LL node 
    struct QNode* temp = newNode(item); 
  
    // If queue is empty, then new node is front and rear both 
    if (q->rear == NULL) { 
        q->front = q->rear = temp; 
        return; 
    } 
  
    // Add the new node at the end of queue and change rear 
    q->rear->next = temp; 
    q->rear = temp; 
    
} 
  
// Function to remove a key from given queue q 
struct QItem deQueue(struct Queue* q) 
{ 
    // Store previous front and move front one node ahead 
    struct QNode* temp = q->front; 
  
    q->front = q->front->next; 
  
    // If front becomes NULL, then change rear also as NULL 
    if (q->front == NULL) 
        q->rear = NULL; 
    struct QItem res = temp->item;
    free(temp);
    return res;
} 

void clearQueue(struct Queue* q){
    while(!isEmpty(q)) {
        deQueue(q);
    }
}

void printAll(struct Queue* q) {
    while(!isEmpty(q)) {
        struct QItem item = deQueue(q);
        if(item.type == 0) {
            printf("%d ",item.key);
        }
        else if(item.type == 1) {
            printf("%c ",item.key);
        }
        
    }
}
