package me.matt.postgres;

import java.sql.*;

public class Test {

    public static void main(String... args) {

        try {
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/test?currentSchema=sailors");


            String query = "SELECT sname FROM sailors WHERE sid=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, 7);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                System.out.println(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
//CREATE ROLE miriam WITH LOGIN PASSWORD 'jw8s0F4'