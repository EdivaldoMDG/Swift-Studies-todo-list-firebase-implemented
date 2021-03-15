//
//  TaskCellViewModel.swift
//  Todo List FireBase
//
//  Created by Edivaldo Goncalves on 3/11/21.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    //Listens to any change into the task
    @Published var taskRepository = TaskRepository()
    
    @Published  var task: Task
    
    var id = ""
    
    //Listens to any change on the comppletion state
    @Published var completionStateIconName = ""
    
    //To keep track of our subscribers assign them to a cancellable && To use any canceballe we have to import combine
    private var cancellables = Set<AnyCancellable>()
    
   
    
    init(task: Task) {
        self.task = task
        //Checks the state of the task if its completed or not
        $task.map { task in
            task.completed ? "chemark.circle.fill" : "circle"
        }
        
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellables)
       
        //To Keep track of the id
        $task.compactMap{
                task in
            task.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
        //update in firestore
        $task
            //This allows you to send updates to firestore only when you have finishing typing
        
            //make sure if we make changes our self instead of the user we dont send them because we would get an endless loop
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink{
                task in
                self.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
        
    }
    
}

 //We need to view models actualmente temos dois views diferentes O listView e temos o Cellview temos de ter um view model para o list view tambem
