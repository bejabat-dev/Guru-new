const express = require('express');
const bcrypt = require('bcrypt');
const app = express();
const db = require('./db');

app.use(express.json());

const router = express.Router();

const multer = require('multer');
const path = require('path');
const fs = require('fs');

app.use('/guruku/uploads', express.static(path.join(__dirname, 'uploads')));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    const deskripsi = req.body.deskripsi;

    if (!deskripsi) {
      return cb(new Error('Email is required in request body'), null);
    }

    const fileExtension = path.extname(file.originalname);
    const newFileName = `${deskripsi}${fileExtension}`;
    const uploadPath = path.join('uploads/', newFileName);

    // Check if file exists and delete it if so
    if (fs.existsSync(uploadPath)) {
      fs.unlinkSync(uploadPath);
    }

    cb(null, newFileName);
  },
});

const upload = multer({ storage: storage });
const baseUrl = 'http://192.168.1.2:3000/guruku';

router.post('/upload/foto', upload.single('image'), async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ message: 'No file uploaded' });
  }

  const { email } = req.body;

  try {
    const fileUrl = `${baseUrl}/uploads/${req.file.filename}`;
    const updateQuery = 'UPDATE users SET foto_profil = ? WHERE email = ?';

    await db.query(updateQuery, [fileUrl, email]);
    res.status(200).json({ message: 'Success' });
  }

  catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.post('/upload/mapel', upload.single('image'), async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ message: 'No file uploaded' });
  }

  const { deskripsi, tarif } = req.body;

  try {
    const fileUrl = `${baseUrl}/uploads/${req.file.filename}`;
    const updateQuery = 'INSERT INTO mata_pelajaran (deskripsi,tarif,icon) VALUES (?,?,?)';

    await db.query(updateQuery, [deskripsi, tarif, fileUrl]);
    res.status(200).json({ message: 'Success' });
  }

  catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.post('/mapel/delete', async (req, res) => {
  const { id } = req.body;
  try {
    const query = 'DELETE FROM mata_pelajaran WHERE id = ?';
    await db.query(query, [id]);
    res.status(200).json({ message: 'Success' });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.get('/user', async (req, res) => {
  const { email } = req.body;

  try {
    const query = 'SELECT * FROM users WHERE email = ?';
    const [rows] = await db.query(query, [email]);

    if (rows === 0) {
      return res.status(404);
    }

    res.status(200).json(rows[0]);
  } catch (e) {
    res.status(500);
  }
});

router.get('/user/id', async (req, res) => {
  const { id } = req.body;

  try {
    const query = 'SELECT * FROM users WHERE id = ?';
    const [rows] = await db.query(query, [id]);

    if (rows === 0) {
      return res.status(404);
    }

    res.status(200).json(rows[0]);
  } catch (e) {
    res.status(500);
  }
});

router.get('/jadwal', async (req, res) => {
  const { id } = req.body;

  try {
    const query = 'SELECT * FROM jadwal WHERE id_guru = ?';
    const [rows] = await db.query(query, [id]);

    if (rows === 0) {
      return res.status(404);
    }

    res.status(200).json(rows);
  } catch (e) {
    res.status(500);
  }
});

router.post('/jadwal', async (req, res) => {
  const { id, tanggal } = req.body;

  try {
    const query = 'INSERT INTO jadwal (id_guru,tanggal) VALUES (?,?)';
    await db.query(query, [id, tanggal]);

    res.status(200).json({ message: 'Success' });
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: 'Failed' });
  }
});

router.delete('/jadwal', async (req, res) => {
  const { id } = req.body;

  try {
    const query = 'DELETE FROM jadwal WHERE id = ?';
    await db.query(query, [id]);

    res.status(200).json({ message: 'Success' });
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: 'Failed' });
  }
});

router.get('/user/siswa', async (req, res) => {
  const role = 'Siswa';
  try {
    const query = 'SELECT * FROM users WHERE role = ?';
    const [rows] = await db.query(query, [role]);

    if (rows === 0) {
      return res.status(404);
    }

    res.status(200).json(rows);
  } catch (e) {
    return res.status(500).json(e);
  }
});

router.get('/jadwal/guru', async (req, res) => {
  const { id } = req.body;
  try {
    const query = 'SELECT * FROM booking WHERE id_guru = ?';
    await db.query(query, [id]);
    res.status(200).json();
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.post('/order', async (req, res) => {
  const { id_siswa, id_guru, nama_siswa, nama_guru, mata_pelajaran, tarif, tanggal, status } = req.body;
  try {
    const query = 'INSERT INTO booking (id_siswa,id_guru,nama_siswa,nama_guru,mata_pelajaran,tarif,tanggal,status) VALUES(?,?,?,?,?,?,?,?)';
    await db.query(query, [id_siswa, id_guru, nama_siswa, nama_guru, mata_pelajaran, tarif, tanggal, status]);
    res.status(200).json();
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.get('/order/guru', async (req, res) => {
  const { id } = req.body;
  try {
    const query = 'SELECT * FROM booking WHERE id_guru = ?';
    const [rows] = await db.query(query, [id]);

    res.status(200).json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.get('/riwayat/guru', async (req, res) => {
  const { id } = req.body;
  const stat = 'Menunggu konfirmasi';
  try {
    const query = 'SELECT * FROM booking WHERE id_guru = ? AND status != ?';
    const [rows] = await db.query(query, [id, stat]);

    res.status(200).json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.post('/update/order', async (req, res) => {
  const { id, stat } = req.body;
  try {
    const query = 'UPDATE booking SET status = ? WHERE id = ?';
    await db.query(query, [stat, id]);

    res.status(200).json();
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.get('/order', async (req, res) => {
  const { id_siswa } = req.body;
  try {
    const query = 'SELECT * FROM booking WHERE id_siswa = ?';
    const [rows] = await db.query(query, [id_siswa]);

    res.status(200).json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: 'Error' });
  }
});

router.get('/user/guru', async (req, res) => {
  const role = 'Guru';
  const mapel = 'Belum disetel';
  try {
    const query = 'SELECT * FROM users WHERE role = ? AND mata_pelajaran != ?';
    const [rows] = await db.query(query, [role, mapel]);

    if (rows === 0) {
      return res.status(404).json({ message: 'Empty' })
    }

    res.status(200).json(rows);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e);
  }
});

router.post('/register', async (req, res) => {
  const { nama, email, password, role } = req.body;

  try {
    const checkEmail = 'SELECT email FROM users WHERE email = ?';
    const [rows, field] = await db.query(checkEmail, [email]);
    if (rows.length > 0) {
      return res.status(501).json({ message: "Email has been taken" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const query = 'INSERT INTO users (nama, email, password, role) VALUES (?, ?, ?, ?)';
    await db.query(query, [nama, email, hashedPassword, role]);

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const query = 'SELECT * FROM users WHERE email = ?';
    const [rows] = await db.query(query, [email]);

    if (rows.length === 0) {
      return res.status(404).json({ message: 'Email not found' });
    }

    const user = rows[0];
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return res.status(401).json({ message: 'Invalid password' });
    }

    res.status(200).json({ message: 'Login successful', user: { id: user.id, nama: user.nama, email: user.email, role: user.role, mata_pelajaran: user.mata_pelajaran } });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

router.get('/kategori', async (req, res) => {
  const query = 'SELECT * FROM mata_pelajaran';
  try {
    const [rows] = await db.query(query);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json(err);
  }
});

router.get('/list_kategori', async (req, res) => {
  const { mapel } = req.body;
  const query = 'SELECT * FROM users WHERE mata_pelajaran = ?';
  try {
    const [rows] = await db.query(query, [mapel]);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json(err);
  }
});

router.post('/user/updateguru', async (req, res) => {
  const { nama, alamat, nohp, mata_pelajaran, email } = req.body;
  const query = 'UPDATE users SET nama = ?,alamat =?,nohp=?,mata_pelajaran=? WHERE email = ?';

  try {
    await db.query(query, [nama, alamat, nohp, mata_pelajaran, email]);
    res.status(200).json({ message: 'Success' });
  } catch (e) {
    console.error(e);
    return res.status(500);
  }
});

router.post('/siswa/delete', async (req, res) => {
  const { id } = req.body;
  try {
    await db.query('DELETE FROM users WHERE id=?',[id]);
    res.status(200).json('Ok');
  } catch (e) {
    return res.status(500).json('error');
  }
});

router.post('/guru/delete', async (req, res) => {
  const { id } = req.body;
  try {
    await db.query('DELETE FROM users WHERE id=?',[id]);
    res.status(200).json('Ok');
  } catch (e) {
    return res.status(500).json('error');
  }
});



app.use('/guruku', router);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});