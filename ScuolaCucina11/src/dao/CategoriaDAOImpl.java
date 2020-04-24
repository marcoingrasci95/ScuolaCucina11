package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.Categoria;
import exceptions.ConnessioneException;

public class CategoriaDAOImpl implements CategoriaDAO {

	private Connection conn;
	private static final String INSERT = "insert into categoria (descrizione) values (?)";
	private static final String UPDATE = "update categoria set descrizione=? where id_categoria=?";
	private static final String DELETE = "delete from categoria where id_categoria=?";
	private static final String SELECT = "select descrizione from categoria where id_categoria=?";
	private static final String SELECT_ALL = "select * from categoria";

	public CategoriaDAOImpl() throws ConnessioneException {
		conn = SingletonConnection.getInstance();
	}

	/*
	 * inserimento di una nuova categoria
	 * 
	 */
	@Override
	public void insert(String descrizione) throws SQLException {
		PreparedStatement ps = conn.prepareStatement(INSERT);
		ps.setString(1, descrizione);
		if (ps.executeUpdate() == 0)
			throw new SQLException("Problema nell'inserimento della categoria");
	}

	/*
	 * modifica del nome di una categoria. la categoria viene individuata in base al
	 * idCategoria se la categoria non esiste si solleva una eccezione
	 */
	@Override
	public void update(Categoria c) throws SQLException {
		PreparedStatement ps = conn.prepareStatement(UPDATE);
		ps.setString(1, c.getDescrizione());
		ps.setInt(2, c.getIdCategoria());
		if (ps.executeUpdate() == 0)
			throw new SQLException("La categoria non è presente");
	}

	/*
	 * cancellazione di una singola categoria una categoria si può cancellare solo
	 * se non ci sono dati correlati se la categoria non esiste o non è cancellabile
	 * si solleva una eccezione
	 */
	@Override
	public void delete(int idCategoria) throws SQLException {
		PreparedStatement ps = conn.prepareStatement(DELETE);
		ps.setInt(1, idCategoria);
		if (ps.executeUpdate() == 0)
			throw new SQLException("Non è possibile eliminare la categoria");

	}

	/*
	 * lettura di una singola categoria in base al suo id se la categoria non esiste
	 * si solleva una eccezione
	 */
	@Override
	public Categoria select(int idCategoria) throws SQLException {
		Categoria categoria = new Categoria();
		PreparedStatement ps = conn.prepareStatement(SELECT);
		ps.setInt(1, idCategoria);
		ps.executeQuery();
		try (ResultSet rs = ps.executeQuery()) {
			if (rs.next())
				categoria = new Categoria(rs.getInt(1), rs.getString(2));
			return categoria;
		} catch (SQLException se) {
			throw new SQLException("Database issue " + se.getMessage());
		}

	}

	/*
	 * lettura di tutte le categorie se non vi sono categoria il metodo ritorna una
	 * lista vuota
	 */
	@Override
	public ArrayList<Categoria> select() throws SQLException {
		ArrayList<Categoria> lista = new ArrayList<Categoria>();
		PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
		try (ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				lista.add(new Categoria(rs.getInt(1), rs.getString(2)));
			}
			return lista;
		} catch (SQLException se) {
			throw new SQLException("Database issue " + se.getMessage());
		}
	}

}
