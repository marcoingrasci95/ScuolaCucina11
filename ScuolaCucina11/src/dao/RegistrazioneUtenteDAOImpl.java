package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entity.Utente;
import exceptions.ConnessioneException;

public class RegistrazioneUtenteDAOImpl implements RegistrazioneUtenteDAO {

	private Connection conn;
	private static final String INSERT_utente = "INSERT INTO `registrati` (`id_utente`, `password`, `nome`, `cognome`, `dataNascita`, `email`, `telefono`) VALUES(?, ?, ?, ?,?,?,?);";
	private static final String UPDATE_utente = "UPDATE `registrati` SET `password`=?, `nome`=?, `cognome`=?, `dataNascita`=?, `email`=?, `telefono`=? WHERE id_utente` = ?;";
	private static final String DELETE_utente = "DELETE from registrati WHERE id_utente=?";
	private static final String SELECT_utenti = "SELECT * FROM registrati";
	private static final String SELECT_utente = "SELECT * FROM registrati WHERE id_utente=?";

	public RegistrazioneUtenteDAOImpl() throws ConnessioneException {
		conn = SingletonConnection.getInstance();
	}

	/*
	 * registrazione di un nuovo utente alla scuola di formazione se l'utente già
	 * esiste si solleva una eccezione
	 */
	@Override
	public void insert(Utente u) throws SQLException {
		try (Statement stmt = conn.createStatement(); PreparedStatement ps = conn.prepareStatement(INSERT_utente)) {
			ps.setString(1, u.getIdUtente());
			ps.setString(2, u.getPassword());
			ps.setString(3, u.getNome());
			ps.setString(4, u.getCognome());
			ps.setDate(5, new java.sql.Date(u.getDataNascita().getTime()));
			ps.setString(6, u.getEmail());
			ps.setString(7, u.getTelefono());
			ps.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		}
	}

	/*
	 * modifica di tutti i dati di un utente l'utente viene individuato dal suo
	 * idUtente se l'utente non esiste si solleva una exception
	 */
	@Override
	public void update(Utente u) throws SQLException {
		try (Statement stmt = conn.createStatement(); PreparedStatement ps = conn.prepareStatement(UPDATE_utente)) {
			ps.setString(7, u.getIdUtente());
			ps.setString(1, u.getPassword());
			ps.setString(2, u.getNome());
			ps.setString(3, u.getCognome());
			ps.setDate(4, new java.sql.Date(u.getDataNascita().getTime()));
			ps.setString(5, u.getEmail());
			ps.setString(6, u.getTelefono());
			ps.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		}

	}

	/*
	 * cancellazione di un singolo utente l'utente si può cancellare solo se non è
	 * correlato ad altri dati se l'utente non esiste o non è cancellabile si
	 * solleva una eccezione
	 */
	@Override
	public void delete(String idUtente) throws SQLException {
		try (Statement stmt = conn.createStatement(); PreparedStatement ps = conn.prepareStatement(DELETE_utente)) {
			ps.setString(1, idUtente);
			ps.executeUpdate();
		} catch (SQLException se) {
			se.printStackTrace();
		}

	}

	/*
	 * lettura di tutti gli utenti registrati se non ci sono utenti registrati il
	 * metodo ritorna una lista vuota
	 */
	@Override
	public ArrayList<Utente> select() throws SQLException {
		ArrayList<Utente> results = new ArrayList<>();
		try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(SELECT_utenti)) {
			while (rs.next()) {
				Utente utente = new Utente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getDate(5), rs.getString(6), rs.getString(7), false);
				results.add(utente);
			}

		}
		return null;
	}

	/*
	 * lettura dei dati di un singolo utente se l'utente non esiste si solleva una
	 * eccezione
	 */
	@Override
	public Utente select(String idUtente) throws SQLException {

		try (Statement stmt = conn.createStatement(); PreparedStatement ps = conn.prepareStatement(SELECT_utente)) {
			ps.setString(1, idUtente);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Utente utente = new Utente(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
							rs.getDate(5), rs.getString(6), rs.getString(7), false);
					return utente;
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
