const db = require('../config/db');
const bcrypt = require('bcryptjs');

class Member {
    static async create(name, email, password) {
        try {
            const hashedPassword = await bcrypt.hash(password, 8);
            const query = `INSERT INTO members (Name, Email, PasswordHash) VALUES (?, ?, ?)`;
            const [result] = await db.execute(query, [name, email, hashedPassword]);
            return result.insertId;
        } catch (err) {
            throw err;
        }
    }

    static async findByEmail(email) {
        try {
            const query = `SELECT * FROM members WHERE Email = ?`;
            const [results] = await db.execute(query, [email]);
            if (results.length > 0) {
                return results[0]; // assumes email is unique
            } else {
                return null;
            }
        } catch (err) {
            throw err;
        }
    }
    static async findById(memberId) {
        const [rows] = await db.execute('SELECT MemberID, Email, Name, PasswordHash FROM members WHERE MemberID = ?', [memberId]);
        return rows[0];
    }

    static async updateById(memberId, email, name, passwordHash) {
        const [result] = await db.execute(
            'UPDATE members SET Email = ?, Name = ?, PasswordHash = ? WHERE MemberID = ?',
            [email, name, passwordHash, memberId]
        );
        return result;
    }
    static async createComment(memberId, comment, cardId) {
        try {
            const query = `INSERT INTO comments (MemberID, Comment,CollectionID) VALUES (?, ?, ?)`;
            const [result] = await db.execute(query, [memberId, comment, cardId]);
            return result.insertId;
        } catch (err) {
            throw err;
        }
    }

    static async createCollection(memberId, name, description, creationDate) {
        try {
            const query = `
                INSERT INTO collections (MemberID, Name, Description) 
                VALUES (?, ?, ?);
            `;
            const [result] = await db.execute(query, [memberId, name, description]);
            return result.insertId;
        } catch (err) {
            throw err;
        }
    }
    static async getCommentsByCardId(cardId) {
        try {
            const query = `SELECT * FROM comments WHERE CollectionID = ? ORDER BY CommentDate DESC`;
            const [results] = await db.execute(query, [cardId]);
            return results;
        } catch (err) {
            throw err;
        }
    }

}

module.exports = Member;
