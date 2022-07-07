using burakcanyildizbackend.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace burakcanyildizbackend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SystemController : ControllerBase
    {

        private readonly AppDbContext _context;
        public ILogger<User> _logger;
        public IWebHostEnvironment _hostingEnvironment;
        private readonly IHttpContextAccessor _http;
        private readonly IConfiguration _configuration;
        public SystemController(AppDbContext context, ILogger<User> logger, IWebHostEnvironment hostingEnvironment, IHttpContextAccessor http, IConfiguration configuration)
        {
            _context = context;
            _logger = logger;
            _hostingEnvironment = hostingEnvironment;
            _http = http;
            _configuration = configuration;
        }

        [HttpPost("UserRegister")]
        public async Task<IActionResult> Register(User user)
        {

            try
            {

                var oldUs = _context.Users.Where(x => x.Email == user.Email || x.Phone == user.Phone).FirstOrDefault();

                if (oldUs != null)
                {
                    return BadRequest("var");
                }
                else
                {
                    _context.Users.Add(user);

                    await _context.SaveChangesAsync();

                    return Ok(user);

                }

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }


        [HttpGet("UserLogin")]
        public async Task<IActionResult> UserLogin(string email, string password)
        {

            try
            {

                var oldUs = _context.Users.Where(x => x.Email == email && x.Password == password).FirstOrDefault();


                if (oldUs != null)
                {
                    return Ok(oldUs);

                }
                else
                {
                    return BadRequest("yanlış");
                }

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpPost("CompanyRegister")]
        public async Task<IActionResult> CompanyRegister(Company company)
        {

            try
            {

                var oldcom = _context.Users.Where(x => x.Email == company.Email || x.Phone == company.Phone).FirstOrDefault();

                if (oldcom != null)
                {
                    return BadRequest("var");
                }
                else
                {
                    _context.Companies.Add(company);

                    await _context.SaveChangesAsync();

                    return Ok(company);

                }

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }


        [HttpGet("CompanyLogin")]
        public async Task<IActionResult> CompanyLogin(string email, string password)
        {

            try
            {

                var oldUs = _context.Companies.Where(x => x.Email == email && x.Password == password).FirstOrDefault();

                if (oldUs != null)
                {
                    return Ok(oldUs);
                }
                else
                {
                    return BadRequest("yanlış");
                }

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }


        [HttpPost("UpdateUser")]
        public async Task<IActionResult> UpdateUser(User user)
        {

            try
            {

                _context.Users.Update(user);

                await _context.SaveChangesAsync();

                return Ok(user);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpPost("UpdateCompany")]
        public async Task<IActionResult> UpdateCompany(Company company)
        {

            try
            {

                _context.Companies.Update(company);

                await _context.SaveChangesAsync();

                return Ok(company);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetUserInfo")]
        public async Task<IActionResult> GetUserInfo(int id)
        {

            try
            {

                var us = _context.Users.Where(x => x.Id == id).FirstOrDefault();

                return Ok(us);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetCompanyInfo")]
        public async Task<IActionResult> GetCompanyInfo(int id)
        {

            try
            {

                var us = _context.Companies.Where(x => x.Id == id).FirstOrDefault();

                return Ok(us);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }



        [HttpPost("CreateBurs")]
        public async Task<IActionResult> CreateBurs(Burs burs)
        {

            try
            {

                _context.Burss.Add(burs);

                await _context.SaveChangesAsync();

                return Ok(burs);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpPost("UpdateBurs")]
        public async Task<IActionResult> UpdateBurs(Burs burs)
        {

            try
            {

                _context.Burss.Update(burs);

                await _context.SaveChangesAsync();

                return Ok(burs);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }


        [HttpPost("CreateSoru")]
        public async Task<IActionResult> CreateSoru(Soru soru)
        {

            try
            {

                _context.Sorus.Add(soru);

                await _context.SaveChangesAsync();

                return Ok(soru);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpPost("CreateCevap")]
        public async Task<IActionResult> CreateCevap(Cevap[] cevap)
        {

            try
            {
                for (int i = 0; i < cevap.Length; i++)
                {
                    _context.Cevaps.Add(cevap[i]);
                }

                await _context.SaveChangesAsync();

                return Ok(cevap);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpPost("CreateTest")]
        public async Task<IActionResult> CreateTest(Test test)
        {

            try
            {

                _context.Tests.Add(test);

                await _context.SaveChangesAsync();

                return Ok(test);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpPost("CreateTestCevaps")]
        public async Task<IActionResult> CreateTestCevaps(TestCevap[] cevaps)
        {

            try
            {

                for (int i = 0; i < cevaps.Length; i++)
                {
                    _context.TestCevaps.Add(cevaps[i]);

                    await _context.SaveChangesAsync();

                }

                return Ok(cevaps);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetBurs")]
        public async Task<IActionResult> GetBurs(int id)
        {

            try
            {

                var test = _context.Burss.Where(x => x.Id == id).FirstOrDefault();

                return Ok(test);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [HttpGet("GetBurss")]
        public async Task<IActionResult> GetBurss(int userId)
        {

            try
            {

                var burss = _context.Burss.Where(x => x.isShow == 1).ToArray();

                var usTests = _context.Tests.Where(x => x.UserId == userId).ToArray();


                for (int i = 0; i < burss.Length; i++)
                {
                    for (int j = 0; j < usTests.Length; j++)
                    {
                        if (burss[i].Id == usTests[j].BursId)
                        {
                            burss = burss.Where((source, index) => index != i).ToArray();
                        }
                    }
                }

                return Ok(burss);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [HttpGet("GetCompanyBurss")]
        public async Task<IActionResult> GetCompanyBurss(int companyId)
        {

            try
            {

                var test = _context.Burss.Where(x => x.CompanyId == companyId).ToArray();

                return Ok(test);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }



        [HttpGet("GetSorus")]
        public async Task<IActionResult> GetSorus(int bursId)
        {

            try
            {

                var test = _context.Sorus.Where(x => x.BursId == bursId).ToArray();

                return Ok(test);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetCevaps")]
        public async Task<IActionResult> GetCevaps(int soruId)
        {

            try
            {

                var test = _context.Cevaps.Where(x => x.SoruId == soruId).ToArray();

                return Ok(test);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetUserTests")]
        public async Task<IActionResult> GetUserTests(int id)
        {

            try
            {

                var test = _context.Tests.Where(x => x.UserId == id).Include(x => x.Burs).Include(x => x.User).ToArray();

                return Ok(test);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetTestCevaps")]
        public async Task<IActionResult> GetTestCevaps(int userId, int testId)
        {

            try
            {

                var cevaps = _context.TestCevaps.Where(x => x.UserId == userId && x.TestId == testId).Include(x => x.Cevap).Include(x => x.User).Include(x => x.Soru).ToArray();

                return Ok(cevaps);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetBasvuranlar")]
        public async Task<IActionResult> GetBasvuranlar(int companyId)
        {

            try
            {
                var burss = _context.Burss.Where(x => x.CompanyId == companyId).ToArray();

                List<Test> testler = new List<Test>();

                for (int i = 0; i < burss.Length; i++)
                {
                    var liste = _context.Tests.Where(x => x.BursId == burss[i].Id && x.IsWon == 0).Include(x => x.User).Include(x => x.Burs).OrderByDescending(x => x.Puan).ToList();

                    foreach (var item in liste)
                    {
                        testler.Add(item);

                    }
                }


                return Ok(testler);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

        [HttpGet("GetKazananlar")]
        public async Task<IActionResult> GetKazananlar(int companyId)
        {

            try
            {
                var burss = _context.Burss.Where(x => x.CompanyId == companyId).ToArray();

                List<Test> testler = new List<Test>();

                for (int i = 0; i < burss.Length; i++)
                {
                    var liste = _context.Tests.Where(x => x.BursId == burss[i].Id && x.IsWon == 1).Include(x => x.User).Include(x => x.Burs).OrderByDescending(x => x.Puan).ToList();

                    foreach (var item in liste)
                    {
                        testler.Add(item);

                    }
                }


                return Ok(testler);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }


        [HttpGet("ChangeTestStatu")]
        public async Task<IActionResult> ChangeTestStatu(int testId, int statu)
        {

            try
            {
                var t = _context.Tests.Where(x => x.Id == testId).FirstOrDefault();

                t.IsWon = statu;

                _context.Tests.Update(t);

                await _context.SaveChangesAsync();

                return Ok(t);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("ChangeBursShown")]
        public async Task<IActionResult> ChangeBursShown(int bursId, int statu)
        {

            try
            {
                var bu = _context.Burss.Where(x => x.Id == bursId).FirstOrDefault();
                if (statu == 0)
                {
                    bu.isShow = 0;
                }
                else
                {
                    bu.isShow = 1;
                }

                _context.Burss.Update(bu);

                await _context.SaveChangesAsync();

                return Ok(bu);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("Sonuclandir")]
        public async Task<IActionResult> Sonuclandir(int bursId)
        {

            try
            {
                var bu = _context.Burss.Where(x => x.Id == bursId).FirstOrDefault();

                var tests = _context.Tests.Where(x => x.BursId == bursId).OrderByDescending(x => x.Puan).ToArray();

                for (int i = 0; i < tests.Length; i++)
                {
                    if (i < bu.Kontenjan)
                    {
                        tests[i].IsWon = 1;

                        _context.Tests.Update(tests[i]);
                    }
                }

                await _context.SaveChangesAsync();

                return Ok(bu);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPost("UploadImage")]
        public async Task<IActionResult> SaveImage(int id)
        {
            try
            {
                var file = Request.Form.Files[0];
                string[] sonuc = file.FileName.Split('.');

                var dsa = Request.Form;
                var folderName = Path.Combine("Content", "Images");
                var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);

                //var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');
                var fileName = DateTime.Now.Millisecond.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + "." + sonuc[1].ToString();
                var fullPath = Path.Combine(pathToSave, fileName);
                var dbPath = Path.Combine(folderName, fileName);
                using (var stream = new FileStream(fullPath, FileMode.Create))
                {
                    file.CopyTo(stream);
                }

                var user = _context.Users.Where(x => x.Id == id).FirstOrDefault();
                user.pictureUrl = fileName;

                _context.Users.Update(user);
                await _context.SaveChangesAsync();

                return Ok("Başarılı");
            }
            catch (Exception e)
            {

                return BadRequest(e);
            }

        }

        [HttpGet("ForgotPassword")]
        public async Task<IActionResult> ForgotPassword(string email, int statu)
        {

            try
            {

                string password = "";


                if (statu == 0)
                {
                    password = _context.Users.Where(x => x.Email == email).FirstOrDefault().Password;
                }
                else
                {
                    password = _context.Companies.Where(x => x.Email == email).FirstOrDefault().Password;
                }

                if (String.IsNullOrEmpty(password))
                {
                    return BadRequest("yok");
                }

                SmtpClient sc = new SmtpClient();
                sc.Port = 587;
                sc.Host = "smtp.gmail.com";
                sc.EnableSsl = true;
                sc.UseDefaultCredentials = false;

                sc.Credentials = new NetworkCredential("bursdegerlendirme@gmail.com", "burs1234");
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("bursdegerlendirme@gmail.com", "Burs Değerlendirme");
                mail.To.Add(email);
                mail.IsBodyHtml = true;
                mail.Subject = "Şifremi Unuttum";
                mail.Body = "Unutulan Şifreniz: " + password;

                await sc.SendMailAsync(mail);

                return Ok("basarili");

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }

    }
}
