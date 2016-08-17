using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QLHDCD.Models;
namespace QLHDCD.Controllers
{
    public class DHCDController : Controller
    {
        //
        // GET: /DHCD/
        public ActionResult Index()
        {
            QLDHCDEntities data = new QLDHCDEntities();
            List<DHCD> lst = new List<DHCD>();
            lst = (from lstdhcd in data.DHCDs select lstdhcd).ToList();
            return View(lst);
        }
        public ActionResult Create()
        {
            DHCD f = new DHCD();
            return View(f);
        }

        public ActionResult InsertDHCD(DHCD f)
        {
            QLDHCDEntities data = new QLDHCDEntities();
            data.DHCDs.Add(f);
            data.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult EditDHCD(string madh)
        {
            QLDHCDEntities data = new QLDHCDEntities();
            DHCD dhcd = (from v in data.DHCDs
                         where v.MADH == madh
                         select v).First();
            return View("EditDHCD", dhcd);

        }
        public ActionResult UpdateDHCD(DHCD f)
        {
            QLDHCDEntities data = new QLDHCDEntities();
            DHCD dhcd = (from v in data.DHCDs
                         where v.MADH == f.MADH
                         select v).First();
            dhcd.TenDH = f.TenDH;
            dhcd.nQKin = f.nQKin;
            dhcd.nQBefore = f.nQBefore;
            dhcd.nDeCuHDQT = f.nDeCuHDQT;
            dhcd.nDeCuBKS = f.nDeCuBKS;
            dhcd.nUngCuBKS = f.nUngCuBKS;
            dhcd.nUngCuHDQT = f.nUngCuHDQT;
            dhcd.thoiGian = f.thoiGian;
            dhcd.ACTIVE = f.ACTIVE;
            dhcd.TONGSOPHIEU = f.TONGSOPHIEU;

            data.SaveChanges();
            return RedirectToAction("Index");

        }

        public ActionResult DetailDHCD(string madh)
        {
            QLDHCDEntities data = new QLDHCDEntities();
            DHCD dhcd = (from v in data.DHCDs
                         where v.MADH == madh
                         select v).First();
            ViewBag.madh = dhcd.MADH;
            return View(dhcd);
        }

        public ActionResult DeleteDHCD(string madh)
        {
            QLDHCDEntities data = new QLDHCDEntities();
            DHCD dhcd = (from v in data.DHCDs
                         where v.MADH == madh
                         select v).First();
            data.DHCDs.Remove(dhcd);
            data.SaveChanges();

            return RedirectToAction("Index");
        }

        
	}
}