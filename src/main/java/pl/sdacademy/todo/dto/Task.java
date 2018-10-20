package pl.sdacademy.todo.dto;

import lombok.Data;

@Data
public class Task {

    private String description;

    public static Task create(String description) {
        Task task = new Task();
        task.setDescription(description);
        return task;
    }
}
