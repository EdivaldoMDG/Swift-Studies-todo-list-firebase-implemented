//
//  TaskListViewModel.swift
//  Todo List FireBase
//
//  Created by Edivaldo Goncalves on 3/11/21.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published  var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        //Here we will use the data that we are fetching and listening from our repository
        taskRepository.$tasks
            .map{ tasks in
                tasks.map {
                    task in
                    
                    TaskCellViewModel(task: task)
                    
                }
                
            }.assign(to: \.taskCellViewModels, on: self)
            .store(in: &cancellables)
        
        //        self.taskCellViewModels = testDataTasks.map {
        //            task in
        //            TaskCellViewModel(task: task)
        //        }
    }
    // We need to bind them to the ui TaskListView
    func addTask(task: Task){
        //Add to firestore
        do{
            taskRepository.addTask(task )
        }
        //        let taskVM = TaskCellViewModel(task: task)
        //        self.taskCellViewModels.append(taskVM)
        
    }
    
}


