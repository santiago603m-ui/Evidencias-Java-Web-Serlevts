package com.biblioteca.biblioteca.modelo;

public class Libro {

    private int idLibro;
    private String titulo;
    private String autor;
    private int disponibles;

    public Libro() {
    }

    public Libro(int idLibro, String titulo, String autor, int disponibles) {
        this.idLibro = idLibro;
        this.titulo = titulo;
        this.autor = autor;
        this.disponibles = disponibles;
    }

    public int getIdLibro() {
        return idLibro;
    }

    public void setIdLibro(int idLibro) {
        this.idLibro = idLibro;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public int getDisponibles() {
        return disponibles;
    }

    public void setDisponibles(int disponibles) {
        this.disponibles = disponibles;
    }
}
