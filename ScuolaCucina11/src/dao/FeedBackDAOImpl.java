package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entity.Feedback;
import exceptions.ConnessioneException;

public class FeedBackDAOImpl implements FeedbackDAO {

	private Connection conn;
	private static final String INSERT = "INSERT INTO feedack (id_feedback, id_edizione, id_utente, descrizione, voto) VALUES(?, ?, ?, ?, ?);";
	private static final String SELECT_UTENTE_EDIZIONE = "select * from feedback where id_edizione=? and id_utente=?;";
	private static final String UPDATE_FEEDBACK = "UPDATE feedback set id_edizione=? , set id_utente=?, set descrizione=?, set voto=? where feedback_id=?;";
	private static final String SELECT_FEEDBACK = "select * from feedback where id_feedback=?;";
	private static final String DELETE_FEEDBACK = "delete from feedback where id_feedback=?;";
	private static final String SELECT_EDIZIONE = "select * from feedback where id_edizione=?;";
	private static final String SELECT_UTENTE = "select * from feedback where id_utente=?;";
	private static final String SELECT_CORSO = "select * from calendario join feedback using(id_edizione) where id_corso=?;";


	public FeedBackDAOImpl() throws ConnessioneException {
		conn = SingletonConnection.getInstance();
	}

	/*
	 * inserimento di un singolo feedbak relativo ad una edizione di un corso da
	 * parte di un utente se un utente ha già inserito un feedback per una certa
	 * edizione si solleva una eccezione
	 */
	@Override
	public void insert(Feedback feedback) throws SQLException {
		try (PreparedStatement ps1 = conn.prepareStatement(SELECT_UTENTE_EDIZIONE)) {
			ps1.setInt(1, feedback.getIdEdizione());
			ps1.setString(2, feedback.getIdUtente());
			if (ps1.executeQuery().next())
				throw new SQLException("L'utente ha già lasciato un feedback per questa edizione");
			else {
				try (PreparedStatement ps = conn.prepareStatement(INSERT)) {
					ps.setInt(1, feedback.getIdFeedback());
					ps.setInt(2, feedback.getIdEdizione());
					ps.setString(3, feedback.getIdUtente());
					ps.setString(4, feedback.getDescrizione());
					ps.setInt(5, feedback.getVoto());
					if (ps.executeUpdate() == 0)
						throw new SQLException("Problema nell'esecuzione dell'insert");
				}
			}
		} catch (SQLException se) {
			throw new IllegalStateException("Database issue " + se.getMessage());
		}

	}

	/*
	 * modifica di tutti i dati di un singolo feedback un feedback viene individuato
	 * attraverso l'idFeedback se il feedback non esiste si solleva una eccezione
	 */
	@Override
	public void update(Feedback feedback) throws SQLException {
		try (PreparedStatement ps = conn.prepareStatement(SELECT_FEEDBACK)) {
			ps.setInt(1, feedback.getIdFeedback());
			if (!ps.executeQuery().next())
				throw new SQLException("Il feedback che si vuole modificare non esiste.");
		}
		try (PreparedStatement ps = conn.prepareStatement(UPDATE_FEEDBACK)) {
			ps.setInt(1, feedback.getIdEdizione());
			ps.setString(2, feedback.getIdUtente());
			ps.setString(3, feedback.getDescrizione());
			ps.setInt(4, feedback.getVoto());
			ps.setInt(5, feedback.getIdFeedback());
			if (ps.executeUpdate() == 0)
				throw new SQLException("Problema nell'esecuzione dell'insert");
		}
	}

	/*
	 * cancellazione di un feedback se il feedback non esiste si solleva una
	 * eccezione
	 */
	@Override
	public void delete(int idFeedback) throws SQLException {
		try (PreparedStatement ps = conn.prepareStatement(DELETE_FEEDBACK)) {
			ps.setInt(1, idFeedback);
			if (ps.executeUpdate() == 0)
				throw new SQLException("Il feedback che si vuole eliminare non esiste.");
		}
	}

	/*
	 * lettura di un singolo feedback scritto da un utente per una certa edizione se
	 * il feedback non esiste si solleva una eccezione
	 */
	@Override
	public Feedback selectSingoloFeedback(int idUtente, int idEdizione) throws SQLException {
		    PreparedStatement ps = conn.prepareStatement(SELECT_UTENTE_EDIZIONE);
			ps.setInt(1, idEdizione);
			ps.setInt(2, idUtente);
				try (ResultSet rs = ps.executeQuery()){
					Feedback feedback=new Feedback(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5));
					return feedback;
				}catch (SQLException se) {
					throw new SQLException("Database issue " + se.getMessage());
	       }
		}

	/*
	 * lettura di tutti i feedback di una certa edizione se non ci sono feedback o
	 * l'edizione non esiste si torna una lista vuota
	 */
	@Override
	public ArrayList<Feedback> selectPerEdizione(int idEdizione) throws SQLException {
		 ArrayList<Feedback> feedback= new ArrayList<Feedback>();
		PreparedStatement ps = conn.prepareStatement(SELECT_EDIZIONE);
		ps.setInt(1, idEdizione);
			try (ResultSet rs = ps.executeQuery()){
				while(rs.next())
				 feedback.add(new Feedback(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5)));
			}
			catch (SQLException se) {
				throw new SQLException("Database issue " + se.getMessage());
       }
			return feedback;

	}

	/*
	 * lettura di tutti i feedback scritti da un certo utente se non ci sono
	 * feedback o l'utente non esiste si torna una lista vuota
	 */
	@Override
	public ArrayList<Feedback> selectPerUtente(String idUtente) throws SQLException {
		 ArrayList<Feedback> feedback= new ArrayList<Feedback>();
			PreparedStatement ps = conn.prepareStatement(SELECT_UTENTE);
			ps.setString(1, idUtente);
				try (ResultSet rs = ps.executeQuery()){
					while(rs.next())
					 feedback.add(new Feedback(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5)));
				}
				catch (SQLException se) {
					throw new SQLException("Database issue " + se.getMessage());
	       }
				return feedback;		
	}

	/*
	 * lettura di tutti i feedback scritti per un certo corso (nota: non edizione ma
	 * corso) se non ci sono feedback o il corso non esiste si torna una lista vuota
	 */
	@Override
	public ArrayList<Feedback> selectFeedbackPerCorso(int idCorso) throws SQLException {
		ArrayList<Feedback> feedback= new ArrayList<Feedback>();
		PreparedStatement ps = conn.prepareStatement(SELECT_CORSO);
		ps.setInt(1, idCorso);
			try (ResultSet rs = ps.executeQuery()){
				while(rs.next())
				 feedback.add(new Feedback(rs.getInt(2), rs.getString(3), rs.getString(4), rs.getInt(5)));
			}
			catch (SQLException se) {
				throw new SQLException("Database issue " + se.getMessage());
       }
			return feedback;		
	}

}
