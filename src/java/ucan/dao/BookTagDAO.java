package ucan.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import ucan.models.BookTagModel;
import ucan.conection.DBConnection;

public class BookTagDAO {

    private DBConnection connection;

    public BookTagDAO() {
    }

    public void create(BookTagModel bookTag) {
        String sql = "INSERT INTO livro_descritores(fk_livro, fk_descritores) values(?, ?)";
        try {
            connection = new DBConnection();
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setInt(1, bookTag.getBookId());
            ps.setInt(2, bookTag.getTagId());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.closeConnection();
            }
        }
    }

    public void update(BookTagModel bookTag) {
        String sql = "UPDATE livro_descritores SET fk_livro = ?, fk_descritores = ? WHERE pk_livro_descritores = ?";
        try {
            connection = new DBConnection();
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);

            ps.setInt(1, bookTag.getBookId());
            ps.setInt(2, bookTag.getTagId());
            ps.setInt(3, bookTag.getBookTagId());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.closeConnection();
            }
        }
    }

    public void delete(int bookTagId) {
        String sql = "DELETE FROM livro_descritores WHERE pk_livro_descritores = ?";
        try {
            connection = new DBConnection();
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setInt(1, bookTagId);

            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.closeConnection();
            }
        }
    }

    public List<BookTagModel> getAll() {
        String sql = "SELECT * FROM livro_descritores";

        List<BookTagModel> bookTagList = new ArrayList<>();

        try {
            connection = new DBConnection();
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                BookTagModel location = new BookTagModel();
                location.setBookTagId(resultSet.getInt(1));
                location.setBookId(resultSet.getInt(2));
                location.setTagId(resultSet.getInt(3));
                location.setCreationDate(resultSet.getTimestamp(4).toLocalDateTime());

                bookTagList.add(location);
            }
            ps.close();
            resultSet.close();

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            if (connection != null) {
                connection.closeConnection();
            }
        }
        return bookTagList;
    }

    public BookTagModel getBookTagById(int locationId) {
        String sql = "SELECT * FROM livro_descritores WHERE pk_livro_descritores = ?";

        try {
            connection = new DBConnection();
            BookTagModel location = new BookTagModel();
            PreparedStatement ps = connection.getConnection().prepareStatement(sql);
            ps.setInt(1, locationId);

            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                location.setBookTagId(resultSet.getInt(1));
                location.setBookId(resultSet.getInt(2));
                location.setTagId(resultSet.getInt(3));
                location.setCreationDate(resultSet.getTimestamp(4).toLocalDateTime());
            }

            ps.close();
            resultSet.close();
            return location;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.closeConnection();
            }
        }
        return null;
    }
}
