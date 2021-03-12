  //
  //  ContentView.swift
  //  Todo List FireBase
  //
  //  Created by Edivaldo Goncalves on 3/10/21.
  //
  
  import SwiftUI
  
  struct TaskListView: View {
    //Binding the view models to the UI we need a reference to our task list view model
    @ObservedObject var taskListVM = TaskListViewModel()
    
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading  ) {
                List {
                    ForEach(taskListVM.taskCellViewModels){ taskCellVM in
                        TaskCell(TaskCellVM: taskCellVM)
                    }
                    if presentAddNewItem {
                        TaskCell(TaskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))){
                            task in
                             self.taskListVM.addTask(task: task)
                            //isto quer dizer que quando adicionarmos um novo elemento a celula abaixo para adicionar uma nova celula desaparece
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action:{
                    self.presentAddNewItem.toggle()
                }) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add New Task")
                    }
                    
                }.padding()
            }
            .navigationBarTitle("Tasks")
        }
        
        
    }
  }
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
  }
  
  struct TaskCell: View {
    @ObservedObject var TaskCellVM: TaskCellViewModel
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack{
            Image(systemName: TaskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.TaskCellVM.task.completed.toggle()
                }
            TextField("Enter the task title",text: $TaskCellVM.task.title, onCommit:{
                self.onCommit(self.TaskCellVM.task)
            })
        }
    }
  }
  
